-- exercício 1--
DELIMITER ??
CREATE PROCEDURE listando_autoures()
BEGIN
    SELECT nome, sobrenome FROM Autor;
END
??
DELIMITER ;

CALL listando_autoures();

-- exercício 2 --
DELIMITER //
CREATE PROCEDURE categoria_dos_livros (IN p_categoria varchar(100))
BEGIN
    SELECT titulo FROM Livro 
    WHERE Categoria_ID = (SELECT Categoria_ID FROM Categoria 
    WHERE Nome = p_categoria);
END
//
DELIMITER ;
CALL categoria_dos_livros("Romance");
CALL categoria_dos_livros("Autoajuda");
CALL categoria_dos_livros("Ficção Científica");

-- exercício 3 --
DELIMITER //
CREATE PROCEDURE sp_LivrosPorCategoria(IN p_categoria varchar(100))
BEGIN
    SELECT Categoria_ID AS ID_DA_CATEGÓRIA , COUNT(*) AS QUANTIDADE_DE_LIVROS FROM Livro 
    WHERE Categoria_ID = (SELECT Categoria_ID FROM Categoria 
    WHERE Nome = p_categoria) GROUP BY Categoria_ID ORDER BY COUNT(Categoria_ID);
END
//

DELIMITER ;
drop procedure sp_LivrosPorCategoria;
CALL sp_LivrosPorCategoria("Autoajuda");

-- exercício 4 --
DELIMITER //
CREATE PROCEDURE sp_VerificarLivrosCategoria(IN categoria_valor varchar(100), OUT tf_livros varchar(30))
BEGIN
    DECLARE verificar INT;
    WITH Selet_ID as (
        SELECT (select Categoria_ID from categoria where nome = Categoria_valor) as cate_valor
    )


    SELECT COUNT(*) INTO verificar FROM livro INNER JOIN Selet_ID on cate_valor = Categoria_ID;
    IF verificar > 0 THEN
        SET tf_livros = 'Possui Livros';
    ELSE
        SET tf_livros = 'Não Possui Livros';
    END IF;
END;
//
DELIMITER ;
DROP PROCEDURE  sp_VerificarLivrosCategoria;
CALL sp_VerificarLivrosCategoria('Ciência', @ver);
SELECT @ver as tem_ou_não;

-- exercício 5 --
DELIMITER //
CREATE PROCEDURE sp_LivrosAteAno(IN p_lpano INT)
  BEGIN
    SELECT Titulo, Ano_Publicacao FROM Livro
    WHERE Ano_Publicacao <= p_lpano;
	END
//
DELIMITER ;
CALL sp_LivrosAteAno(2004);
drop procedure sp_LivrosAteAno;

-- exercício 6 --
DELIMITER //
CREATE PROCEDURE categoria_dos_livros (IN p_categoria varchar(100))
BEGIN
    SELECT titulo FROM Livro 
    WHERE Categoria_ID = (SELECT Categoria_ID FROM Categoria 
    WHERE Nome = p_categoria);
END
//
DELIMITER ;
CALL sp_LivrosPorCategoria("Romance");
CALL sp_LivrosPorCategoria("Autoajuda");
CALL sp_LivrosPorCategoria("Ficção Científica");

-- exercício 7 --
DELIMITER //
CREATE PROCEDURE sp_AdicionarLivro(
    IN N_Livro_ID INT,
    IN N_Titulo VARCHAR(255),
    IN N_Editora_ID INT,
    IN N_Ano_Publicacao INT,
    IN N_Numero_Paginas INT,
    IN N_Categoria_ID INT
)
BEGIN
    DECLARE livro_existente INT;

    SELECT COUNT(*) INTO livro_existente FROM Livro WHERE Titulo = n_titulo;

    IF livro_existente = 0 THEN
        INSERT INTO Livro (Livro_ID, Titulo, Editora_ID, Ano_Publicacao, Numero_Paginas, Categoria_ID)
        VALUES (N_Livro_ID, N_Titulo, N_Editora_ID, N_Ano_Publicacao, N_Numero_Paginas, N_Categoria_ID);
    END IF;

END;
//
DELIMITER ;

CALL sp_AdicionarLivro(22, 'Peppa Pig e os 7 Anões/Branca de neve e o Negão de Máua', 2, 1945, 666, 1);
SELECT * FROM LIVRO;

-- exercício 8 --
DELIMITER //

CREATE PROCEDURE EncontrarAutorMaisAntigo()
BEGIN
    SELECT nome, Sobrenome
    FROM Autor
    WHERE data_nascimento = (SELECT MIN(data_nascimento) FROM Autor);
END 
//
DELIMITER ;
drop procedure EncontrarAutorMaisAntigo;
CALL EncontrarAutorMaisAntigo();

-- exercício 9 --
Esse exercício criar um procedimento armazenado chamado "listando autores" 
que extrai nomes e sobrenomes da tabela "Autor". A instrução DELIMITER é usada para temporariamente mudar o delimitador SQL
para ';' dentro do procedimento. O procedimento é definido com CREATE PROCEDURE, iniciado com BEGIN, contendo uma consulta SELECT e finalizado com END. Em seguida, DELIMITER é
restaurado para seu valor padrão. Finalmente, o procedimento é chamado com CALL listando_autores(); para listar os nomes e sobrenomes dos autores da tabela. Isso permite a execução eficiente dessa operação específica no banco de dados.
