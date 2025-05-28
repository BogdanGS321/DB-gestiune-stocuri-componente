CLEAR SCREEN
DROP TABLE Gestiune_GBS;
DROP TABLE Componente_GBS;
DROP TABLE Furnizori_GBS;
DROP TABLE DescriereMatOferite_GBS;
DROP TABLE Documente_GBS;

CREATE TABLE Documente_GBS (
    NrDocument  Number(4),
    TipDocument Varchar2(20)
        CONSTRAINT nn_tipdocument_GBS NOT NULL
        CONSTRAINT ck_tipdocument_GBS CHECK(LENGTH(TipDocument)>5),
    Data        DATE DEFAULT SysDate,
    CONSTRAINT pk_nrdocument_GBS PRIMARY KEY (NrDocument)
        
);

DESCRIBE Documente_GBS;

CREATE TABLE DescriereMatOferite_GBS (
    IDDescriere      Number(2),
    MaterialeOferite Varchar2(35)
        CONSTRAINT nn_materialeoferite_GBS NOT NULL,
    Descriere        Varchar2(100)
        CONSTRAINT uq_descriere_GBS UNIQUE
        CONSTRAINT ck_descriere_GBS CHECK(LENGTH(Descriere)>15),    
    CONSTRAINT pk_iddescriere_GBS PRIMARY KEY (IDDescriere)
   
);

DESCRIBE DescriereMatOferite_GBS;

CREATE TABLE Furnizori_GBS (
    IDFurnizor      Number(2),
    CUI             Varchar2(10)
        CONSTRAINT uq_cui_GBS UNIQUE
        CONSTRAINT ck_cui_GBS CHECK(LENGTH(CUI)>2),
    DenumireCompanie Varchar2(30)
        CONSTRAINT nn_dencomp_GBS NOT NULL,
    IDDescriere     Number(2),
    CONSTRAINT pk_idfurnizor_GBS PRIMARY KEY (IDFurnizor),
    CONSTRAINT fk_iddescriere_GBS FOREIGN KEY (IDDescriere) REFERENCES DescriereMatOferite_GBS (IDDescriere)

);

DESCRIBE Furnizori_GBS;

CREATE TABLE Componente_GBS (
    IDComponenta    Number(3),
    DenumireComponenta  Varchar2(25)
        CONSTRAINT ck_dencompon_GBS CHECK(LENGTH(DenumireComponenta)>5),
    Specificatii Varchar2(75),
    UnitateDeMasura Varchar2(7)
        CONSTRAINT nn_um_GBS NOT NULL,
    IDFurnizor      Number(2),
    CONSTRAINT pk_idcomponenta_GBS PRIMARY KEY (IDComponenta),
    CONSTRAINT fk_idfurnizor_GBS FOREIGN KEY (IDFurnizor) REFERENCES Furnizori_GBS (IDFurnizor)
);

DESCRIBE Componente_GBS;

CREATE TABLE Gestiune_GBS (
    IDGestiune  Number(4),
    Cantitate   Number(3)
        CONSTRAINT nn_cantitate_GBS NOT NULL,
    PretUnitar  Number(5, 2) DEFAULT NULL
        CONSTRAINT ck_pretunitar_GBS CHECK(PretUnitar>0),
    IDComponenta Number(3),
    NrDocument Number(4),
    CONSTRAINT pk_idgestiune_GBS PRIMARY KEY (IDGestiune),
    CONSTRAINT fk_idcomponenta_GBS FOREIGN KEY (IDComponenta) REFERENCES Componente_GBS (IDComponenta),
    CONSTRAINT fk_nrdocument_GBS FOREIGN KEY (NrDocument) REFERENCES Documente_GBS (NrDocument)

);

DESCRIBE Gestiune_GBS;

ALTER TABLE Componente_GBS ADD (Detalii Varchar2(30));
ALTER TABLE Gestiune_GBS MODIFY IDComponenta NOT NULL;
ALTER TABLE Componente_GBS MODIFY DenumireComponenta Varchar2(30);
ALTER TABLE Documente_GBS DROP CONSTRAINT ck_tipdocument_GBS;
ALTER TABLE Documente_GBS ADD CONSTRAINT ck_tipdocument_GBS CHECK(LENGTH(TipDocument)>10);
ALTER TABLE Componente_GBS DROP COLUMN Detalii;

DESCRIBE Componente_GBS;
DESCRIBE Gestiune_GBS;

CLEAR COLUMNS
CLEAR BUFFER

SET LINESIZE 150
SET PAGESIZE 30
COLUMN NrDocument HEADING 'Numar document' JUSTIFY CENTER
COLUMN TipDocument HEADING 'Tip document' JUSTIFY CENTER
COLUMN Data HEADING 'Data intocmire document' JUSTIFY CENTER

COLUMN IDDescriere FORMAT 99 HEADING 'ID Descriere'
COLUMN MaterialeOferite FORMAT A35 HEADING 'Materiale oferite' WORD_WRAPPED JUSTIFY CENTER
COLUMN Descriere FORMAT A40 WORD_WRAPPED

COLUMN IDFurnzior FORMAT 99 HEADING 'ID Furnizor' JUSTIFY CENTER
COLUMN CUI FORMAT 9999999999 HEADING 'CUI furnizor' JUSTIFY CENTER
COLUMN DenumireCompanie HEADING 'Denumire companie' WORD_WRAPPED

COLUMN IDComponenta FORMAT 999 HEADING 'ID Componenta'
COLUMN DenumireComponenta HEADING 'Denumire componenta' WORD_WRAPPED
COLUMN Specificatii FORMAT A45 HEADING 'Specificatii tehnice' WORD_WRAPPED JUSTIFY CENTER
COLUMN UnitateDeMasura HEADING 'U.M.' JUSTIFY CENTER

COLUMN IDGestiune FORMAT 9999 HEADING 'ID mod. gestiune'
COLUMN Cantitate FORMAT 999
COLUMN PretUnitar FORMAT 999.99 HEADING 'Pret unitar'


DELETE FROM Gestiune_GBS;
DELETE FROM Componente_GBS;
DELETE FROM Documente_GBS;
DELETE FROM Furnizori_GBS;
DELETE FROM DescriereMatOferite_GBS;

INSERT INTO DescriereMatOferite_GBS VALUES (1, 'Condensatori si componente mici', 'Componente mici pentru circuite precum condensatoare, cipuri');
INSERT INTO DescriereMatOferite_GBS VALUES (2, 'Motoare electrice', 'Motoare electrice de marimi, viteze si tensiuni diferite');
INSERT INTO DescriereMatOferite_GBS VALUES (3, 'Cabluri', 'Cabluri electrice de materiale, rezistente si grosimi diverse');
INSERT INTO DescriereMatOferite_GBS VALUES (4, 'Tevi', 'Tevi din materiale precum plastic si otel inoxidabil');
INSERT INTO DescriereMatOferite_GBS VALUES (5, 'Garnituri', 'Garnituri de diverse forme si marimi');

SELECT * FROM DescriereMatOferite_GBS;

INSERT INTO Documente_GBS VALUES (1, 'Nota de receptie', TO_DATE('13-02-2024', 'DD-MM-YYYY'));
INSERT INTO Documente_GBS VALUES (2, 'Bon de consum', TO_DATE('15-03-2024', 'DD-MM-YYYY'));
INSERT INTO Documente_GBS VALUES (3, 'Bon de consum', TO_DATE('20-03-2024', 'DD-MM-YYYY'));
INSERT INTO Documente_GBS VALUES (4, 'Nota de receptie', TO_DATE('10-04-2024', 'DD-MM-YYYY'));
INSERT INTO Documente_GBS VALUES (5, 'Bon de consum', TO_DATE('20-04-2024', 'DD-MM-YYYY'));

SELECT * FROM Documente_GBS;

INSERT INTO Furnizori_GBS VALUES (1, 318923, 'Electrika S.R.L.', 1);
INSERT INTO Furnizori_GBS VALUES (2, 591252, 'Adrian Motors S.A.', 2);
INSERT INTO Furnizori_GBS VALUES (3, 657234, 'Pipe Solutions S.R.L', 4);
INSERT INTO Furnizori_GBS VALUES (4, 569034, 'Rubber Solution S.A', 5);
INSERT INTO Furnizori_GBS VALUES (5, 418945, 'Precision Wiring S.R.L', 3);

SELECT * FROM Furnizori_GBS;

INSERT INTO Componente_GBS VALUES (10, 'Motor electric', '24v, 1000RPM, 30x30 cm', 'buc.', 2);
INSERT INTO Componente_GBS VALUES (20, 'Teava otel inoxidabil', '50cm lungime, 10cm diametru', 'buc.', 3);
INSERT INTO Componente_GBS VALUES (30, 'Cablu de cupru', '2cm grosime', 'm', 5);
INSERT INTO Componente_GBS VALUES (40, 'Garnitura rotunda', '10cm diametru', 'buc.', 4);
INSERT INTO Componente_GBS VALUES (50, 'Condensator', '25mF', 'buc.', 1);

SELECT * FROM Componente_GBS;

INSERT INTO Gestiune_GBS VALUES (1, 30, 0.05, 50, 1);
INSERT INTO Gestiune_GBS VALUES (2, 3, 30.50, 10, 1);
INSERT INTO Gestiune_GBS VALUES (3, 10, 2.50, 30, 1);
INSERT INTO Gestiune_GBS VALUES (4, -10, NULL, 50, 2);
INSERT INTO Gestiune_GBS VALUES (5, -3, NULL, 10, 3);

SELECT * FROM Gestiune_GBS;


-- Sa se afiseze valoarea totala a componentelor cu care s-a aprovizionat societatea in anul 2024 de la un furnizor introdus de la tastatura

ACCEPT furnizor PROMPT 'Introduceti furnizorul: ';

SELECT DenumireComponenta, SUM(PretUnitar*Cantitate) AS Valoare FROM 
    Gestiune_GBS g JOIN Componente_GBS c ON g.IDComponenta=c.IDComponenta JOIN Documente_GBS d ON g.NrDocument=d.NrDocument
        WHERE (IDFurnizor = (SELECT IDFurnizor FROM Furnizori_GBS WHERE DenumireCompanie = '&furnizor') 
            AND EXTRACT(YEAR FROM Data) = 2024 AND Cantitate > 0) GROUP BY DenumireComponenta;


-- Sa se afiseze toate componentele impreuna cu nivelul lor de stoc (stoc scazut, mediu, suficient).
SELECT DenumireComponenta, SUM(Cantitate) AS Cantitate, 
    DECODE(SUM(Cantitate), 0,'Inexistent', 1,'Scazut', 2,'Mediu', 3,'Suficient', 'Suficient') AS NivelStoc 
    FROM Gestiune_GBS g JOIN Componente_GBS c ON g.IDComponenta = c.IDComponenta GROUP BY DenumireComponenta;


-- Sa se afiseze datele componentelor cu care compania nu s-a aprovizionat niciodata
SELECT IDComponenta, DenumireComponenta, Specificatii, UnitateDeMasura 
    FROM Componente_GBS
MINUS 
SELECT c.IDComponenta, DenumireComponenta, Specificatii, UnitateDeMasura 
    FROM Gestiune_GBS g JOIN Componente_GBS c ON g.IDComponenta = c.IDComponenta;


-- Sa se afiseze evolutia pretului unei componente prin diferenta dintre pretul unitar al primei aprovizionari si pretul unitar al urmatoarei aprovizionari

SELECT IDComponenta, PretUnitar, LAG(PretUnitar, 1, 0) OVER (ORDER BY PretUnitar) AS PretAnterior, 
    LAG(PretUnitar, 1, 0) OVER (ORDER BY PretUnitar) - PretUnitar AS Diferenta
    FROM Gestiune_GBS WHERE Cantitate > 0 AND IDComponenta = 10 ORDER BY IDComponenta ASC;

-- Sa se afiseze datele componentelor care au fost achizitionate in luna aprilie 2024 ale caror pret unitar este mai mic decat cea a oricarei componente ce a fost achizitionata in lunile anterioare

SELECT c.IDComponenta, DenumireComponenta, Specificatii, UnitateDeMasura, PretUnitar FROM 
    Gestiune_GBS g JOIN Documente_GBS d ON g.NrDocument = d.NrDocument JOIN Componente_GBS c ON g.IDComponenta = c.IDComponenta
    WHERE (Data >= TO_DATE('01-04-2024', 'DD-MM-YYYY') AND Data < TO_DATE('01-05-2024', 'DD-MM-YYYY') AND 
        PretUnitar < (SELECT MIN(PretUnitar) FROM Gestiune_GBS g JOIN Documente_GBS d ON g.NrDocument = d.NrDocument 
                        WHERE Data < TO_DATE('01-04-2024', 'DD-MM-YYYY')));

-- Sa se afiseze datele furnizorilor care vand in mod exclusiv componente cu cantitati exprimate in 'buc.'

SELECT DenumireCompanie, CUI, MaterialeOferite, Descriere 
    FROM Furnizori_GBS f JOIN Componente_GBS c ON f.IDFurnizor=c.IDFurnizor 
            JOIN DescriereMatOferite_GBS d ON f.IDDescriere = d.IDDescriere
                WHERE UnitateDeMasura = 'buc.';

-- 
