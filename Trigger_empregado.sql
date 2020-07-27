CREATE OR REPLACE FUNCTION fn_audit_departamento()RETURNS trigger AS $$
DECLARE
	OPERACAO char(1);
	ALTERACAO text DEFAULT '';
	ORIGINAL text DEFAULT '';
	id integer;
BEGIN
	SELECT COALESCE (MAX(id_audit),0)+1 INTO id FROM auditoria;
	IF TG_OP = 'INSERT' THEN OPERACAO :='I';
	ELSIF TG_OP = 'DELETE' THEN OPERACAO :='D';
	ELSIF TG_OP = 'UPDATE' THEN OPERACAO :='U';
	END IF;
	IF TG_OP = 'UPDATE' THEN
		IF NEW.codempregado != OLD.codempregado THEN
			ALTERACAO := ALTERACAO || 'codempregado=' || NEW.codempregado || ',';
			ORIGINAL := ORIGINAL || 'codempregado=' || OLD.codempregado ||',';
		END IF;
		IF NEW.nomeinic != OLD.nomeinic THEN
			ALTERACAO := ALTERACAO || 'nomeinic=' || NEW.nomeinic || ',';
			ORIGINAL := ORIGINAL || 'nomeinic=' || OLD.nomeinic ||',';
		END IF;
		IF NEW.nomeint != OLD.nomeint THEN
			ALTERACAO := ALTERACAO || 'nomeint=' || NEW.nomeint || ',';
			ORIGINAL := ORIGINAL || 'nomeint=' || OLD.nomeint ||',';
		END IF;
		IF NEW.nomefin != OLD.nomefin THEN
			ALTERACAO := ALTERACAO || 'nomefin=' || NEW.nomefin || ',';
			ORIGINAL := ORIGINAL || 'nomefin=' || OLD.nomefin ||',';
		END IF;
		IF NEW.datanasc != OLD.datanasc THEN
			ALTERACAO := ALTERACAO || 'datanasc=' || NEW.datanasc || ',';
			ORIGINAL := ORIGINAL || 'datanasc=' || OLD.datanasc ||',';
		END IF;
		IF NEW.endereco != OLD.endereco THEN
			ALTERACAO := ALTERACAO || 'endereco=' || NEW.endereco || ',';
			ORIGINAL := ORIGINAL || 'endereco=' || OLD.endereco ||',';
		END IF;
		IF NEW.sexo != OLD.sexo THEN
			ALTERACAO := ALTERACAO || 'sexo=' || NEW.sexo || ',';
			ORIGINAL := ORIGINAL || 'sexo=' || OLD.sexo ||',';
		END IF;
		IF NEW.salario != OLD.salario THEN
			ALTERACAO := ALTERACAO || 'salario=' || NEW.salario || ',';
			ORIGINAL := ORIGINAL || 'salario=' || OLD.salario ||',';
		END IF;
		IF NEW.salario != OLD.salario THEN
			ALTERACAO := ALTERACAO || 'salario=' || NEW.salario || ',';
			ORIGINAL := ORIGINAL || 'salario=' || OLD.salario ||',';
		END IF;
		IF NEW.coddepartamento != OLD.coddepartamento THEN
			ALTERACAO := ALTERACAO || 'coddepartamento=' || NEW.coddepartamento || ',';
			ORIGINAL := ORIGINAL || 'coddepartamento=' || OLD.coddepartamento ||',';
		END IF;
		IF NEW.supcodempregado != OLD.supcodempregado THEN
			ALTERACAO := ALTERACAO || 'supcodempregado=' || NEW.supcodempregado || ',';
			ORIGINAL := ORIGINAL || 'supcodempregado=' || OLD.supcodempregado ||',';
		END IF;
	ELSIF TG_OP = 'DELETE' THEN
		
		ORIGINAL := ORIGINAL || 'codempregado=' || OLD.codempregado || ',';
		ORIGINAL := ORIGINAL || 'nomeinic=' || OLD.nomeinic || ',';
		ORIGINAL := ORIGINAL || 'nomeint=' || OLD.nomeint || ',';
		ORIGINAL := ORIGINAL || 'nomefin=' || OLD.nomefin || ',';
		ORIGINAL := ORIGINAL || 'datanasc=' || OLD.datanasc || ',';
		ORIGINAL := ORIGINAL || 'endereco=' || OLD.endereco || ',';
		ORIGINAL := ORIGINAL || 'sexo=' || OLD.sexo || ',';
		ORIGINAL := ORIGINAL || 'salario=' || OLD.salario || ',';
		ORIGINAL := ORIGINAL || 'coddepartamento=' || OLD.coddepartamento || ',';
		ORIGINAL := ORIGINAL || 'supcodempregado=' || OLD.supcodempregado;
	END IF;
	INSERT INTO auditoria VALUES (id, TG_RELNAME, OLD.coddepartamento, OPERACAO, ALTERACAO, ORIGINAL, current_timestamp);
	RETURN NEW;
END $$ LANGUAGE 'plpgsql'