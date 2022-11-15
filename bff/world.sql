create table public.usuarios (
id_usuario serial NOT NULL,
nome varchar(50) NOT NULL,
CONSTRAINT id_usuario_pk PRIMARY KEY (id_usuario));

create table public.tarefas(
id_tarefa serial not null,
titulo_tarefa varchar(100),
id_usuario int,
CONSTRAINT ID_TAREFA_PK PRIMARY KEY (id_tarefa),
CONSTRAINT ID_USUARIO_FK FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario));

create table public.tarefas_itens(
id_item serial not null,
desc_item varchar(100),
concluido boolean,
id_tarefa int,
CONSTRAINT id_item_PK PRIMARY KEY (id_item),
CONSTRAINT id_tarefa_FK FOREIGN KEY (id_tarefa) REFERENCES tarefas(id_tarefa));

insert into usuarios
(nome)
values ('Mariana');