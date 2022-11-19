CREATE OR REPLACE FUNCTION create_if_not_exists (table_name text, create_stmt text)
RETURNS text AS
$_$
BEGIN

IF EXISTS (
    SELECT *
    FROM   pg_catalog.pg_tables
    WHERE    tablename  = table_name
    ) THEN
   RETURN 'TABLE ' || '''' || table_name || '''' || ' ALREADY EXISTS';
ELSE
   EXECUTE create_stmt;
   RETURN 'CREATED';
END IF;

END;
$_$ LANGUAGE plpgsql;

select create_if_not_exists('usuarios', 'create TABLE usuarios (
id_usuario serial NOT NULL,
nome varchar(50) NOT NULL,
CONSTRAINT id_usuario_pk PRIMARY KEY (id_usuario));');

select create_if_not_exists('tarefas', 'create TABLE tarefas(
id_tarefa serial not null,
titulo_tarefa varchar(100),
id_usuario int,
CONSTRAINT ID_TAREFA_PK PRIMARY KEY (id_tarefa),
CONSTRAINT ID_USUARIO_FK FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario));');

select create_if_not_exists('tarefas_itens', 'create TABLE tarefas_itens(
id_item serial not null,
desc_item varchar(100),
concluido boolean,
id_tarefa int,
CONSTRAINT id_item_PK PRIMARY KEY (id_item),
CONSTRAINT id_tarefa_FK FOREIGN KEY (id_tarefa) REFERENCES tarefas(id_tarefa));');

commit;

DO $$
DECLARE qttUsuario int;
BEGIN
 select count (*)
 into qttUsuario
 from  usuarios;

if qttUsuario = 0 then
insert into usuarios
(nome)
values ('Mariana');
END if;
END $$;

commit;