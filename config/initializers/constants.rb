# IMPORTANT: AVAILABILITY_OPTIONS is used for a bitmask field. Once you have data using a bitmask, don’t change the order of the values, remove any values, or insert any new values in the ':as' array anywhere except at the end. You won’t like the results.
AVAILABILITY_OPTIONS = [
  :local_monday_morning,     :local_monday_afternoon,     :local_monday_night,
  :local_tuesday_morning,    :local_tuesday_afternoon,    :local_tuesday_night,
  :local_wednesday_morning,  :local_wednesday_afternoon,  :local_wednesday_night,
  :local_thursday_morning,   :local_thursday_afternoon,   :local_thursday_night,
  :local_friday_morning,     :local_friday_afternoon,     :local_friday_night,
  :local_saturday_morning,   :local_saturday_afternoon,   :local_saturday_night,
  :local_sunday_morning,     :local_sunday_afternoon,     :local_sunday_night,
  :remote_monday_morning,    :remote_monday_afternoon,    :remote_monday_night,
  :remote_tuesday_morning,   :remote_tuesday_afternoon,   :remote_tuesday_night,
  :remote_wednesday_morning, :remote_wednesday_afternoon, :remote_wednesday_night,
  :remote_thursday_morning,  :remote_thursday_afternoon,  :remote_thursday_night,
  :remote_friday_morning,    :remote_friday_afternoon,    :remote_friday_night,
  :remote_saturday_morning,  :remote_saturday_afternoon,  :remote_saturday_night,
  :remote_sunday_morning,    :remote_sunday_afternoon,    :remote_sunday_night
]

SKILL_OPTIONS = [
  'administracao_e_politicas_publicas',
  'artes_plasticas_e_performances_artisticas',
  'artesanato_e_trabalhos_manuais',
  'ciencias_politicas',
  'design_grafico',
  'design_web_ux',
  'direito',
  'economia_econometria',
  'edicao_de_video_pos_producao',
  'engenharia_de_transportes_e_trafego',
  'estatistica',
  'filmagem',
  'fotografia',
  'intervencoes_urbanas_grafite',
  'jornalismo_assessoria_de_imprensa',
  'linguas_e_traducao',
  'marketing_publicidade',
  'meio_ambiente_e_sustentabilidade',
  'organizacao_de_mobilizacao_de_rua_ocupacoes_do_espaco_publico',
  'pedagogia_e_compartilhamento_de_conhecimento',
  'producao_cultural_e_eventos',
  'programacao_de_softwares_e_aplicativos_ou_web',
  'servico_e_assistencia_social',
  'sociologia_antropologia',
  'urbanismo_e_planejamento_urbano'
]

TOPIC_OPTIONS = [
  :industria_comercio_e_emprego,
  :ciencia_e_tecnologia,
  :direitos_humanos,
  :educacao,
  :esportes_lazer_e_cultura,
  :orcamento_e_fiscalizacao_financeira,
  :saude_e_drogas,
  :criancas_e_adolescentes,
  :pessoas_de_terceira_idade,
  :meio_ambiente_e_direitos_dos_animais,
  :defesa_do_consumidor,
  :obras_publicas_e_infraestrutura,
  :transportes_e_transito,
  :turismo
]
