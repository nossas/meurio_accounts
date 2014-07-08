require 'spec_helper'

describe User do
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should allow_value("email@addresse.foo").for(:email) }
  it { should_not allow_value("foo").for(:email) }
  it { should allow_value("(21) 99999999").for(:phone) }
  it { should allow_value("(21) 999999999").for(:phone) }
  it { should_not allow_value("(21) 9999999").for(:phone) }

  it { should have_many :memberships }
  it { should have_many :organizations }

  describe "#availability" do
    before do
      subject.availability << :remote_monday_night
      subject.availability.delete(:local_friday_morning)
      subject.save
    end

    it 'has availability' do
      subject.availability?.should be_true
    end

    it 'has remote availability on Monday night' do
      subject.availability?(:remote_monday_night).should be_true
    end

    it 'has not local availability on Friday morning' do
      subject.availability?(:local_friday_morning).should be_false
    end
  end

  describe "#skills" do
    before do
      subject.skills = ['administracao_e_politicas_publicas']
      subject.save
    end

    it 'has skills' do
      subject.skills.any?.should be_true
    end

    it 'has skill in Administracao e Politicas Publicas' do
      subject.skills.include?('administracao_e_politicas_publicas').should be_true
    end

    it 'has not skill in Jornalismo Assessoria de Imprensa' do
      subject.skills.include?('jornalismo_assessoria_de_imprensa').should be_false
    end
  end

  describe "#fetch_address" do
    context "when the postcode is valid" do
      before do
        stub_request(:get, "http://brazilapi.herokuapp.com/api?cep=").
          with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
          to_return(:status => 200, :body => '[{"cep":{"valid":true,"result":true,"data":{"id":"19451","cidade":"Rio de Janeiro","logradouro":"Dona Mariana","bairro":"Botafogo","cep":"22280-020","tp_logradouro":"Rua","cidade_sem_acento":"rio de janeiro","cidade_ibge":"3304557","uf":"rj"},"message":""}}]', :headers => {})
      end

      it "should update user attributes" do
        subject.should_receive(:update_columns).with({city: "Rio de Janeiro", address_street: "Rua Dona Mariana", address_district: "Botafogo", state: "rj"})
        subject.fetch_address
      end
    end

    context "when the postcode is invalid" do
      before do
        stub_request(:get, "http://brazilapi.herokuapp.com/api?cep=").
          with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
          to_return(:status => 200, :body => '[{"cep":{"valid":false}}]', :headers => {})
      end

      it "should not update user attributes" do
        subject.should_not_receive(:update_columns)
        subject.fetch_address
      end
    end
  end

  describe '#import_image_from_gravatar' do
    let(:user_image) { "#{Rails.root}/features/support/profile.png" }
    let(:default_image) { 'http://i.imgur.com/hq2wZJm.jpg' }

    context 'when the user already has a profile image' do
      before { @user = User.make! avatar: File.open(user_image) }

      it 'returns the avatar uploaded by the user' do
        expect(@user.avatar_url).to include 'profile.png'
      end
    end

    context "when the user doesn't have a profile image" do
      context 'but he has a gravatar image' do
        before do
          allow_any_instance_of(User).to receive(:gravatar_exists?).and_return(true)
          @user = User.make avatar: nil
        end

        it 'returns the gravatar image' do
          expect(@user).to receive(:update_attribute).once
          @user.save
        end
      end

      context "and doesn't have a gravatar image" do
        before do
          allow_any_instance_of(User).to receive(:gravatar_exists?).and_return(false)
          @user = User.make! avatar: nil
        end

        it 'returns the default image' do
          expect(@user.avatar_url).to eq(default_image)
        end
      end
    end
  end

  describe '#update_mailchimp_subscription' do
    context 'when there is an organization_id' do
      before { subject.organization_id = 1 }
      before { Organization.stub(:find_by_id).with(1).and_return(stub_model Organization) }
      before { Gibbon::API.stub_chain(:lists, :subscribe).and_return({"euid" => "abc"}) }

      it "should subscribe user into the MailChimp list" do
        subject.should_receive(:update_attribute).with(:mailchimp_euid, "abc")
        subject.update_mailchimp_subscription
      end
    end

    context 'when there is no organization_id' do
      it "should not subscribe user into the MailChimp list" do
        subject.should_not_receive(:update_attribute)
        subject.update_mailchimp_subscription
      end
    end
  end
end
