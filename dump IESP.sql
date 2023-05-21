use ok;
select * from escola;

#1)
select id_municipio, avg(nota_idesp_ef_iniciais) as media_iniciais, avg(nota_idesp_ef_finais) as media_finais,
avg(nota_idesp_em) as media_em from escola
group by id_municipio;

#2)
select ano, id_municipio, avg(nota_idesp_ef_iniciais) as media_iniciais, avg(nota_idesp_ef_finais) as media_finais,
avg(nota_idesp_em) as media_em from escola
group by id_municipio,ano;

#3)
select id_municipio,  id_escola_sp, avg(nota_idesp_ef_iniciais) as media_iniciais, avg(nota_idesp_ef_finais) as media_finais,
avg(nota_idesp_em) as media_em from escola
group by id_municipio,id_escola_sp;
