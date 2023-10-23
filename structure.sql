SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for Autorzy
-- ----------------------------
DROP TABLE IF EXISTS `Autorzy`;
CREATE TABLE `Autorzy`  (
  `ID_autor` varchar(36) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT uuid(),
  `imie` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `nazwisko` varchar(40) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `kraj_pochodzenia` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `opis` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID_autor`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for Czytelnicy
-- ----------------------------
DROP TABLE IF EXISTS `Czytelnicy`;
CREATE TABLE `Czytelnicy`  (
  `ID_czytelnik` varchar(36) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT uuid(),
  `imie` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `nazwisko` varchar(40) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `login` varchar(120) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `haslo` varchar(120) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `liczba_wypozyczonych_ksiazek` int(11) UNSIGNED NULL DEFAULT 0,
  PRIMARY KEY (`ID_czytelnik`) USING BTREE,
  CONSTRAINT `limit_wypozyczen` CHECK (`liczba_wypozyczonych_ksiazek` <= 5)
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for Egzemplarz
-- ----------------------------
DROP TABLE IF EXISTS `Egzemplarz`;
CREATE TABLE `Egzemplarz`  (
  `ID_egzemplarz` varchar(36) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT uuid(),
  `ID_ksiazki` varchar(36) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `rok_wydania` year NULL DEFAULT NULL,
  `ID_wydawnictwo` varchar(36) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `ISBN` varchar(17) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `okladka` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `czy_dostepny` tinyint(1) NULL DEFAULT 1,
  PRIMARY KEY (`ID_egzemplarz`) USING BTREE,
  INDEX `ID_ksiazki`(`ID_ksiazki`) USING BTREE,
  INDEX `ID_wydawnictwo`(`ID_wydawnictwo`) USING BTREE,
  CONSTRAINT `Egzemplarz_ibfk_1` FOREIGN KEY (`ID_ksiazki`) REFERENCES `Ksiazki` (`ID_ksiazki`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Egzemplarz_ibfk_2` FOREIGN KEY (`ID_wydawnictwo`) REFERENCES `Wydawnictwo` (`ID_wydawnictwo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for Gatunek
-- ----------------------------
DROP TABLE IF EXISTS `Gatunek`;
CREATE TABLE `Gatunek`  (
  `ID_gatunek` varchar(36) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT uuid(),
  `nazwa_gatunek` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`ID_gatunek`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for Gatunki_ksiazek
-- ----------------------------
DROP TABLE IF EXISTS `Gatunki_ksiazek`;
CREATE TABLE `Gatunki_ksiazek`  (
  `ID_ksiazki` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ID_gatunek` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`ID_ksiazki`, `ID_gatunek`) USING BTREE,
  INDEX `ID_gatunek`(`ID_gatunek`) USING BTREE,
  CONSTRAINT `Gatunki_ksiazek_ibfk_1` FOREIGN KEY (`ID_ksiazki`) REFERENCES `Ksiazki` (`ID_ksiazki`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Gatunki_ksiazek_ibfk_2` FOREIGN KEY (`ID_gatunek`) REFERENCES `Gatunek` (`ID_gatunek`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for Kary
-- ----------------------------
DROP TABLE IF EXISTS `Kary`;
CREATE TABLE `Kary`  (
  `ID_kary` varchar(36) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT uuid(),
  `ID_wypozyczenie` varchar(36) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT uuid(),
  `kara_brutto` double NOT NULL DEFAULT 0,
  `kara_netto` double GENERATED ALWAYS AS (0.82 * `kara_brutto`) VIRTUAL,
  `czy_zaplacone` tinyint(1) NULL DEFAULT 0,
  PRIMARY KEY (`ID_kary`) USING BTREE,
  INDEX `ID_wypozyczenie`(`ID_wypozyczenie`) USING BTREE,
  CONSTRAINT `Kary_ibfk_1` FOREIGN KEY (`ID_wypozyczenie`) REFERENCES `Wypozyczenie` (`ID_wypozyczenie`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for Ksiazki
-- ----------------------------
DROP TABLE IF EXISTS `Ksiazki`;
CREATE TABLE `Ksiazki`  (
  `ID_ksiazki` varchar(36) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT uuid(),
  `tytul` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `liczba_egzemplarzy` int(10) UNSIGNED NOT NULL,
  `liczba_dostepnych_egzemplarzy` int(10) UNSIGNED NOT NULL DEFAULT `liczba_egzemplarzy`,
  `tytul_oryginalu` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT `tytul`,
  PRIMARY KEY (`ID_ksiazki`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for Ksiazki_autorow
-- ----------------------------
DROP TABLE IF EXISTS `Ksiazki_autorow`;
CREATE TABLE `Ksiazki_autorow`  (
  `ID_ksiazki` varchar(36) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ID_autor` varchar(36) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`ID_ksiazki`, `ID_autor`) USING BTREE,
  INDEX `ID_autor`(`ID_autor`) USING BTREE,
  CONSTRAINT `Ksiazki_autorow_ibfk_1` FOREIGN KEY (`ID_autor`) REFERENCES `Autorzy` (`ID_autor`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Ksiazki_autorow_ibfk_2` FOREIGN KEY (`ID_ksiazki`) REFERENCES `Ksiazki` (`ID_ksiazki`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for Wydawnictwo
-- ----------------------------
DROP TABLE IF EXISTS `Wydawnictwo`;
CREATE TABLE `Wydawnictwo`  (
  `ID_wydawnictwo` varchar(36) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT uuid(),
  `nazwa_wydawnictwo` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `logo_wydawnictwo` blob NULL DEFAULT NULL,
  PRIMARY KEY (`ID_wydawnictwo`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for Wypozyczenie
-- ----------------------------
DROP TABLE IF EXISTS `Wypozyczenie`;
CREATE TABLE `Wypozyczenie`  (
  `ID_wypozyczenie` varchar(36) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT uuid(),
  `ID_egzemplarz` varchar(36) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ID_czytelnik` varchar(36) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `data_wypozyczenia` date NOT NULL,
  `spodziewana_data_zwrotu` date NOT NULL DEFAULT (`data_wypozyczenia` + interval 30 day),
  `faktyczna_data_zwrotu` date NULL DEFAULT NULL,
  `czy_oddane` tinyint(1) GENERATED ALWAYS AS (`faktyczna_data_zwrotu` is not null) VIRTUAL,
  PRIMARY KEY (`ID_wypozyczenie`) USING BTREE,
  INDEX `ID_egzemplarz`(`ID_egzemplarz`) USING BTREE,
  INDEX `ID_czytelnik`(`ID_czytelnik`) USING BTREE,
  CONSTRAINT `Wypozyczenie_ibfk_1` FOREIGN KEY (`ID_egzemplarz`) REFERENCES `Egzemplarz` (`ID_egzemplarz`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Wypozyczenie_ibfk_2` FOREIGN KEY (`ID_czytelnik`) REFERENCES `Czytelnicy` (`ID_czytelnik`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for logi
-- ----------------------------
DROP TABLE IF EXISTS `logi`;
CREATE TABLE `logi`  (
  `ID_log` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `login` varchar(120) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `data` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `akcja` enum('Zalogowano','Proba logowania','Wypozyczono ksiazke','Zwrocono ksiazke') CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID_log`, `data`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic PARTITION BY RANGE (year(`data`))
PARTITIONS 2
(PARTITION `przed 2023` VALUES LESS THAN (2023) ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 ,
PARTITION `najnowsze` VALUES LESS THAN (MAXVALUE) ENGINE = InnoDB MAX_ROWS = 0 MIN_ROWS = 0 )
;

-- ----------------------------
-- View structure for vAktualneWypoczyczeniaCzytelnikow
-- ----------------------------
DROP VIEW IF EXISTS `vAktualneWypoczyczeniaCzytelnikow`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `vAktualneWypoczyczeniaCzytelnikow` AS select `c`.`ID_czytelnik` AS `ID_czytelnik`,`c`.`imie` AS `imie`,`c`.`nazwisko` AS `nazwisko`,`c`.`liczba_wypozyczonych_ksiazek` AS `liczba_wypozyczonych_ksiazek`,group_concat(`k`.`tytul` separator ', ') AS `Tytuly ksiazek` from (((`Czytelnicy` `c` left join `Wypozyczenie` `w` on(`c`.`ID_czytelnik` = `w`.`ID_czytelnik`)) left join `Egzemplarz` `e` on(`e`.`ID_egzemplarz` = `w`.`ID_egzemplarz`)) join `Ksiazki` `k` on(`k`.`ID_ksiazki` = `e`.`ID_ksiazki`)) where `w`.`czy_oddane` = 0 group by `c`.`ID_czytelnik`;

-- ----------------------------
-- View structure for vAktualneWypozyczenia
-- ----------------------------
DROP VIEW IF EXISTS `vAktualneWypozyczenia`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `vAktualneWypozyczenia` AS select `c`.`ID_czytelnik` AS `ID_czytelnik`,`c`.`imie` AS `imie`,`c`.`nazwisko` AS `nazwisko`,`w`.`data_wypozyczenia` AS `data_wypozyczenia`,`w`.`spodziewana_data_zwrotu` AS `spodziewana data zwrotu`,`k`.`tytul` AS `tytul ksiazki` from (((`Czytelnicy` `c` left join `Wypozyczenie` `w` on(`c`.`ID_czytelnik` = `w`.`ID_czytelnik`)) left join `Egzemplarz` `e` on(`e`.`ID_egzemplarz` = `w`.`ID_egzemplarz`)) join `Ksiazki` `k` on(`k`.`ID_ksiazki` = `e`.`ID_ksiazki`)) where `w`.`czy_oddane` = 0;

-- ----------------------------
-- View structure for vAutorzy
-- ----------------------------
DROP VIEW IF EXISTS `vAutorzy`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `vAutorzy` AS select `Autorzy`.`imie` AS `imie`,`Autorzy`.`nazwisko` AS `nazwisko`,`Autorzy`.`kraj_pochodzenia` AS `kraj_pochodzenia`,`Autorzy`.`opis` AS `opis` from `Autorzy`;

-- ----------------------------
-- View structure for vCzytelnicy
-- ----------------------------
DROP VIEW IF EXISTS `vCzytelnicy`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `vCzytelnicy` AS select `Czytelnicy`.`imie` AS `imie`,`Czytelnicy`.`nazwisko` AS `nazwisko`,`Czytelnicy`.`liczba_wypozyczonych_ksiazek` AS `liczba wypozyczonych ksiazek` from `Czytelnicy`;

-- ----------------------------
-- View structure for vEgzemplarze
-- ----------------------------
DROP VIEW IF EXISTS `vEgzemplarze`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `vEgzemplarze` AS select `Egzemplarz`.`ID_egzemplarz` AS `ID_egzemplarz`,`Ksiazki`.`tytul` AS `tytul`,group_concat(concat(`Autorzy`.`imie`,' ',`Autorzy`.`nazwisko`) separator ', ') AS `autor`,`Egzemplarz`.`rok_wydania` AS `rok_wydania`,`Egzemplarz`.`ISBN` AS `ISBN`,`Wydawnictwo`.`nazwa_wydawnictwo` AS `wydawnictwo`,`Egzemplarz`.`okladka` AS `okladka` from ((((`Egzemplarz` left join `Ksiazki` on(`Egzemplarz`.`ID_ksiazki` = `Ksiazki`.`ID_ksiazki`)) left join `Wydawnictwo` on(`Egzemplarz`.`ID_wydawnictwo` = `Wydawnictwo`.`ID_wydawnictwo`)) left join `Ksiazki_autorow` on(`Egzemplarz`.`ID_ksiazki` = `Ksiazki_autorow`.`ID_ksiazki`)) left join `Autorzy` on(`Ksiazki_autorow`.`ID_autor` = `Autorzy`.`ID_autor`)) group by `Egzemplarz`.`ID_egzemplarz`;

-- ----------------------------
-- View structure for vGatunkiKsiazek
-- ----------------------------
DROP VIEW IF EXISTS `vGatunkiKsiazek`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `vGatunkiKsiazek` AS select group_concat(`Gatunek`.`nazwa_gatunek` separator ', ') AS `gatunki`,`Ksiazki`.`tytul` AS `tytul` from (`Ksiazki` left join (`Gatunki_ksiazek` left join `Gatunek` on(`Gatunek`.`ID_gatunek` = `Gatunki_ksiazek`.`ID_gatunek`)) on(`Gatunki_ksiazek`.`ID_ksiazki` = `Ksiazki`.`ID_ksiazki`)) group by `Ksiazki`.`tytul`;

-- ----------------------------
-- View structure for vHistoriaWypozyczen
-- ----------------------------
DROP VIEW IF EXISTS `vHistoriaWypozyczen`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `vHistoriaWypozyczen` AS select `c`.`ID_czytelnik` AS `ID_czytelnik`,`c`.`imie` AS `imie`,`c`.`nazwisko` AS `nazwisko`,`w`.`data_wypozyczenia` AS `data_wypozyczenia`,`w`.`faktyczna_data_zwrotu` AS `data_zwrotu`,`k`.`tytul` AS `tytul_ksiazki` from (((`Czytelnicy` `c` left join `Wypozyczenie` `w` on(`c`.`ID_czytelnik` = `w`.`ID_czytelnik`)) left join `Egzemplarz` `e` on(`e`.`ID_egzemplarz` = `w`.`ID_egzemplarz`)) join `Ksiazki` `k` on(`k`.`ID_ksiazki` = `e`.`ID_ksiazki`)) where `w`.`czy_oddane` = 1;

-- ----------------------------
-- View structure for vKaryCzytelnikow
-- ----------------------------
DROP VIEW IF EXISTS `vKaryCzytelnikow`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `vKaryCzytelnikow` AS select `Czytelnicy`.`imie` AS `imie`,`Czytelnicy`.`nazwisko` AS `nazwisko`,`Kary`.`kara_brutto` AS `kara_brutto`,`Kary`.`kara_netto` AS `kara_netto` from (`Czytelnicy` left join (`Kary` join `Wypozyczenie` on(`Wypozyczenie`.`ID_wypozyczenie` = `Kary`.`ID_wypozyczenie`)) on(`Wypozyczenie`.`ID_czytelnik` = `Czytelnicy`.`ID_czytelnik`));

-- ----------------------------
-- View structure for vKsiazkiAutorow
-- ----------------------------
DROP VIEW IF EXISTS `vKsiazkiAutorow`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `vKsiazkiAutorow` AS select group_concat(concat(`Autorzy`.`imie`,' ',`Autorzy`.`nazwisko`) separator ', ') AS `Autor`,`Ksiazki`.`tytul` AS `tytul` from ((`Autorzy` join `Ksiazki_autorow` on(`Autorzy`.`ID_autor` = `Ksiazki_autorow`.`ID_autor`)) join `Ksiazki` on(`Ksiazki_autorow`.`ID_ksiazki` = `Ksiazki`.`ID_ksiazki`)) group by `Ksiazki`.`tytul`;

-- ----------------------------
-- View structure for vKsiazkiGatunkiAutorzy
-- ----------------------------
DROP VIEW IF EXISTS `vKsiazkiGatunkiAutorzy`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `vKsiazkiGatunkiAutorzy` AS select group_concat(distinct concat(`Autorzy`.`imie`,' ',`Autorzy`.`nazwisko`) separator ', ') AS `Autor`,`Ksiazki`.`tytul` AS `tytul`,group_concat(distinct `Gatunek`.`nazwa_gatunek` separator ', ') AS `nazwa_gatunkow` from (((`Ksiazki` left join (`Ksiazki_autorow` left join `Autorzy` on(`Autorzy`.`ID_autor` = `Ksiazki_autorow`.`ID_autor`)) on(`Ksiazki_autorow`.`ID_ksiazki` = `Ksiazki`.`ID_ksiazki`)) left join `Gatunki_ksiazek` on(`Ksiazki`.`ID_ksiazki` = `Gatunki_ksiazek`.`ID_ksiazki`)) left join `Gatunek` on(`Gatunki_ksiazek`.`ID_gatunek` = `Gatunek`.`ID_gatunek`)) group by `Ksiazki`.`tytul`;

-- ----------------------------
-- View structure for vKsiazkiWydawnictwa
-- ----------------------------
DROP VIEW IF EXISTS `vKsiazkiWydawnictwa`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `vKsiazkiWydawnictwa` AS select `Wydawnictwo`.`nazwa_wydawnictwo` AS `nazwa_wydawnictwo`,`Egzemplarz`.`rok_wydania` AS `rok_wydania`,`Egzemplarz`.`ISBN` AS `ISBN`,`Ksiazki`.`tytul` AS `tytul`,group_concat(concat(`Autorzy`.`imie`,' ',`Autorzy`.`nazwisko`) separator ', ') AS `autorzy` from ((((`Wydawnictwo` join `Egzemplarz` on(`Wydawnictwo`.`ID_wydawnictwo` = `Egzemplarz`.`ID_wydawnictwo`)) join `Ksiazki` on(`Egzemplarz`.`ID_ksiazki` = `Ksiazki`.`ID_ksiazki`)) join `Ksiazki_autorow` on(`Egzemplarz`.`ID_ksiazki` = `Ksiazki_autorow`.`ID_ksiazki`)) join `Autorzy` on(`Ksiazki_autorow`.`ID_autor` = `Autorzy`.`ID_autor`)) group by `Egzemplarz`.`ID_egzemplarz`;

-- ----------------------------
-- View structure for vSumaKarCzytelnikow
-- ----------------------------
DROP VIEW IF EXISTS `vSumaKarCzytelnikow`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `vSumaKarCzytelnikow` AS select `Czytelnicy`.`imie` AS `imie`,`Czytelnicy`.`nazwisko` AS `nazwisko`,sum(`Kary`.`kara_brutto`) AS `suma kar brutto`,sum(`Kary`.`kara_netto`) AS `suma kar netto` from (`Czytelnicy` left join (`Kary` join `Wypozyczenie` on(`Wypozyczenie`.`ID_wypozyczenie` = `Kary`.`ID_wypozyczenie`)) on(`Wypozyczenie`.`ID_czytelnik` = `Czytelnicy`.`ID_czytelnik`)) where `Kary`.`czy_zaplacone` = 0 group by `Czytelnicy`.`ID_czytelnik`;

-- ----------------------------
-- Procedure structure for dodaj_autora_do_ksiazki
-- ----------------------------
DROP PROCEDURE IF EXISTS `dodaj_autora_do_ksiazki`;
delimiter ;;
CREATE PROCEDURE `dodaj_autora_do_ksiazki`(IN imie_autora VARCHAR(255),
    IN nazwisko_autora VARCHAR(255),
    IN tytul_ksiazki VARCHAR(255),
		IN kraj_p Varchar(255))
BEGIN
    DECLARE autor_id varchar(36);
    DECLARE ksiazka_id varchar(36);

    -- Znajdź ID autora na podstawie imienia i nazwiska
    SELECT ID_autor INTO autor_id
    FROM Autorzy
    WHERE imie = imie_autora AND nazwisko = nazwisko_autora;

    -- Znajdź ID książki na podstawie tytułu
    SELECT ID_ksiazki INTO ksiazka_id
    FROM Ksiazki
    WHERE tytul = tytul_ksiazki;
		
		-- Jeśli książka nie istnieje, wypisz błąd
    IF ksiazka_id IS NULL THEN
        SELECT 'Książka nie istnieje! Najpierw dodaj książke' AS error;
    ELSE
		-- Jeśli autor nie istnieje, dodaj go do tabeli autorzy
    IF autor_id IS NULL THEN
        INSERT INTO Autorzy (imie, nazwisko, kraj_pochodzenia)
        VALUES (imie_autora, nazwisko_autora, kraj_p);
        SET autor_id = LAST_INSERT_ID(); -- Pobierz ID nowo dodanego autora
    END IF;
		
        -- Dodaj wpis do tabeli ksiazki_autorzy
        INSERT INTO Ksiazki_autorow (ID_autor, ID_ksiazki)
        VALUES (autor_id, ksiazka_id);
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for dodaj_czytelnika
-- ----------------------------
DROP PROCEDURE IF EXISTS `dodaj_czytelnika`;
delimiter ;;
CREATE PROCEDURE `dodaj_czytelnika`(In vimie varchar(50), in vnazwisko varchar(80))
begin 
if (CHAR_LENGTH(vimie)>0 and CHAR_LENGTH(vnazwisko)>0)
THEN
insert ignore into Czytelnicy (imie,  nazwisko) values (vimie, vnazwisko);
else
SELECT 'Czytelnik musi miec imie i nazwisko' AS error;
END if;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for dodaj_egzemplarz
-- ----------------------------
DROP PROCEDURE IF EXISTS `dodaj_egzemplarz`;
delimiter ;;
CREATE PROCEDURE `dodaj_egzemplarz`(IN ile_egzemplarzy int, IN `vtytul` varchar(255),IN `vrok` year,IN `vwydawnictwo` varchar(255),IN `visbn` varchar(17),IN  `vokladka` varchar(60))
BEGIN
	DECLARE ksiazka_id varchar(36);
	DECLARE wydawnictwo_id varchar(36);
	declare flag int DEFAULT 0;
	-- Znajdź ID książki na podstawie tytułu
    SELECT ID_ksiazki INTO ksiazka_id
    FROM Ksiazki
    WHERE tytul = vtytul;
	-- Jeśli ksiazka nie istnieje to wywałaj procedure dodania Ksiazki
	if ksiazka_id is NULL THEN
	
	call dodaj_ksiazke(vtytul, ile_egzemplarzy , NULL);
	SELECT ID_ksiazki INTO ksiazka_id
    FROM Ksiazki
    WHERE tytul = vtytul;
		set flag = 1;
	end if;
	
	-- Znajdź ID wydawnictwa na podstawie nazwy
    SELECT ID_wydawnictwo INTO wydawnictwo_id
    FROM Wydawnictwo
    WHERE nazwa_wydawnictwo = vwydawnictwo;
	-- Jeśli wydawnictwo nie istnieje to wywołaj procedure dodania wydawnictwa
	if wydawnictwo_id is NULL THEN
	call dodaj_wydawnictwo(vwydawnictwo, NULL);
	SELECT ID_wydawnictwo INTO wydawnictwo_id
    FROM Wydawnictwo
    WHERE nazwa_wydawnictwo = vwydawnictwo;
	end if;
	-- dodaj liczbę egzemplarzy do istniejącej liczby książek w tabeli ksiazki
	if (flag = 0) then
  UPDATE Ksiazki
  SET liczba_egzemplarzy = liczba_egzemplarzy + ile_egzemplarzy,
	 liczba_dostepnych_egzemplarzy = liczba_dostepnych_egzemplarzy + ile_egzemplarzy
  WHERE tytul = vtytul;
	end if;
	
  -- dodaj brakujące egzemplarze
  WHILE (ile_egzemplarzy >= 1) DO
  INSERT INTO Egzemplarz (ID_ksiazki, rok_wydania, ID_wydawnictwo, ISBN, okladka)
  VALUES (ksiazka_id, vrok, wydawnictwo_id, visbn, vokladka);
  SET ile_egzemplarzy = ile_egzemplarzy - 1;
	END WHILE;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for dodaj_gatunek_do_ksiazki
-- ----------------------------
DROP PROCEDURE IF EXISTS `dodaj_gatunek_do_ksiazki`;
delimiter ;;
CREATE PROCEDURE `dodaj_gatunek_do_ksiazki`(IN `vtytul` varchar(255),IN `vgatunek` varchar(255))
BEGIN
    DECLARE gatunek_id varchar(36);
    DECLARE ksiazka_id varchar(36);

    -- Znajdź ID gatunku 
    SELECT ID_gatunek INTO gatunek_id
    FROM Gatunek
    WHERE lower(nazwa_gatunek) = lower(vgatunek);

    -- Znajdź ID książki na podstawie tytułu
    SELECT ID_ksiazki INTO ksiazka_id
    FROM Ksiazki
    WHERE tytul = vtytul;
		
		-- Jeśli książka nie istnieje, wypisz błąd
    IF ksiazka_id IS NULL THEN
        SELECT 'Książka nie istnieje! Najpierw dodaj książke' AS error;
    ELSE
		-- Jeśli gatunek nie istnieje, dodaj go do tabeli gatunek
    IF gatunek_id IS NULL THEN
        INSERT INTO Gatunek (nazwa_gatunek)
        VALUES (vgatunek);
        SET gatunek_id = LAST_INSERT_ID(); -- Pobierz ID nowo dodanego gatunku
    END IF;
        -- Dodaj wpis do tabeli gatunki_ksiazek
        INSERT INTO Gatunki_ksiazek (ID_ksiazki, ID_gatunek)
        VALUES (ksiazka_id, gatunek_id);
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for dodaj_ksiazke
-- ----------------------------
DROP PROCEDURE IF EXISTS `dodaj_ksiazke`;
delimiter ;;
CREATE PROCEDURE `dodaj_ksiazke`(IN `vtytul` varchar(255), IN `vtytul_org` varchar(255))
BEGIN
	DECLARE ksiazka_id varchar(36);

    -- Sprawdź, czy książka już istnieje w tabeli ksiazki
    SELECT ID_ksiazki INTO ksiazka_id
    FROM Ksiazki
    WHERE tytul = vtytul;

    -- Jeśli książka już istnieje, wypisz błąd
    IF ksiazka_id IS NOT NULL THEN
        SELECT 'Książka o podanym tytule już istnieje!' AS error;
    ELSE
			if (CHAR_LENGTH(vtytul)>0) then
				insert ignore into Ksiazki (tytul) values (vtytul);
			ELSE
			SELECT 'Książka nie moze miec pustego tytułu!' AS error;
			end if;
			IF (CHAR_LENGTH(vtytul_org)<=0) THEN 
				INSERT IGNORE INTO Ksiazki (tytul_oryginalu) VALUES (vtytul);
			ELSE 
				INSERT IGNORE INTO Ksiazki (tytul_oryginalu) VALUES (vtytul_org);
			END IF;
		END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for dodaj_wydawnictwo
-- ----------------------------
DROP PROCEDURE IF EXISTS `dodaj_wydawnictwo`;
delimiter ;;
CREATE PROCEDURE `dodaj_wydawnictwo`(IN `vnazwa` varchar(255),IN `vlogo` blob)
BEGIN
	DECLARE wydawnictwo_id varchar(36);

    -- Sprawdź, czy wydawnictwo już istnieje w tabeli Wydawnictwo
    SELECT ID_wydawnictwo INTO wydawnictwo_id
    FROM Wydawnictwo
    WHERE lower(nazwa_wydawnictwo) = lower(vnazwa);

    -- Jeśli wydawnictwo już istnieje, wypisz błąd
    IF wydawnictwo_id IS NOT NULL THEN
        SELECT 'Wydawnictwo o podanej nazwie już istnieje!' AS error;
    ELSE
			if (CHAR_LENGTH(vnazwa)>0 )
			THEN
				insert ignore into Wydawnictwo (nazwa_wydawnictwo) values (vnazwa);
			end if;
			if(vlogo is not null)
			THEN
				insert ignore into Wydawnictwo (logo_wydawnictwo) values (vlogo);
			end if;
		END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for usun_czytelnika
-- ----------------------------
DROP PROCEDURE IF EXISTS `usun_czytelnika`;
delimiter ;;
CREATE PROCEDURE `usun_czytelnika`(In vimie VARCHAR(80), IN `vnazwisko` varchar(80))
BEGIN

	delete from Czytelnicy where vnazwisko=nazwisko and vimie=imie and `liczba_wypozyczonych_ksiazek`=0;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for wypozycz_ksiazke
-- ----------------------------
DROP PROCEDURE IF EXISTS `wypozycz_ksiazke`;
delimiter ;;
CREATE PROCEDURE `wypozycz_ksiazke`()

;;
delimiter ;

-- ----------------------------
-- Procedure structure for wyswietl_czytelnikow_o_danym_nazwisku
-- ----------------------------
DROP PROCEDURE IF EXISTS `wyswietl_czytelnikow_o_danym_nazwisku`;
delimiter ;;
CREATE PROCEDURE `wyswietl_czytelnikow_o_danym_nazwisku`(in vnazwisko varchar(80), out vile int)
BEGIN 
select imie, nazwisko from Czytelnicy where nazwisko=vnazwisko;
set vile = found_rows();

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for zaloguj_uzytkownika
-- ----------------------------
DROP PROCEDURE IF EXISTS `zaloguj_uzytkownika`;
delimiter ;;
CREATE PROCEDURE `zaloguj_uzytkownika`(IN `p_login` varchar(120), IN `p_haslo` varchar(120))
BEGIN
    DECLARE user_count INT;
		DECLARE password_hash VARCHAR (120);
    -- Sprawdzanie, czy podany login istnieje w tabeli użytkowników
    SELECT COUNT(*) INTO user_count FROM Czytelnicy WHERE login = p_login;

    IF user_count > 0 THEN
        
        
        -- Pobieranie zaszyfrowanego hasła dla podanego loginu
        SELECT haslo INTO password_hash FROM Czytelnicy WHERE login = p_login;

        -- Sprawdzanie poprawności hasła
        IF password_hash = SHA1(p_haslo) THEN
            -- Dodawanie rekordu do tabeli logi
            INSERT INTO logi (login, data, akcja) VALUES (p_login, NOW(), 'Zalogowano');
            
            SELECT 'Zalogowano' AS message;
        ELSE
					INSERT INTO logi (login, data, akcja) VALUES (p_login, NOW(), 'Proba logowania');
            SELECT 'Nieprawidłowe hasło' AS message;
        END IF;
    ELSE
        SELECT 'Nieprawidłowy login' AS message;
    END IF;

END
;;
delimiter ;

-- ----------------------------
-- Function structure for zlicz_czytelnikow_z_ksiazkami
-- ----------------------------
DROP FUNCTION IF EXISTS `zlicz_czytelnikow_z_ksiazkami`;
delimiter ;;
CREATE FUNCTION `zlicz_czytelnikow_z_ksiazkami`(`vnazwisko` varchar(80),`vile_ksiazek` int)
 RETURNS int(11)
BEGIN
	declare ile int;
	select count(*) into ile from Czytelnicy where nazwisko LIKE concat('%',vnazwisko,'%')
	and liczba_wypozyczonych_ksiazek>=vile_ksiazek;
	RETURN ile;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for zwroc_egzemplarz
-- ----------------------------
DROP PROCEDURE IF EXISTS `zwroc_egzemplarz`;
delimiter ;;
CREATE PROCEDURE `zwroc_egzemplarz`(IN `vID_egzemplarz` varchar(36))
BEGIN
	declare login_uzytkownika VARCHAR(120);
	
	-- Znajdz login uzytkownika który zwraca --
	SELECT c.login into login_uzytkownika
	FROM Wypozyczenie w
	JOIN Czytelnicy c ON w.ID_czytelnik = c.ID_czytelnik
	WHERE w.ID_egzemplarz = vID_egzemplarz;

	UPDATE Wypozyczenie 
	SET faktyczna_data_zwrotu = CURDATE()
	WHERE ID_egzemplarz = vID_egzemplarz;
	
	INSERT INTO logi (login, data, akcja) VALUES (login_uzytkownika, NOW(), 'Zwrocono ksiazke');
	
END
;;
delimiter ;

-- ----------------------------
-- Event structure for nowa_partycja
-- ----------------------------
DROP EVENT IF EXISTS `nowa_partycja`;
delimiter ;;
CREATE EVENT `nowa_partycja`
ON SCHEDULE
EVERY '1' YEAR STARTS '2023-06-13 23:26:35'
ON COMPLETION PRESERVE
DO begin
set @nowy_rok=year(now())+1;
set @sql = concat("alter table logi reorganize partition najnowsze into\r\n(partition p_", @nowy_rok, " values less than (", (@nowy_rok+1) ,"), partition najnowsze values less than maxvalue);");
prepare st1 from @sql;
execute st1;
deallocate prepare st1;
end
;;
delimiter ;

-- ----------------------------
-- Event structure for usun_stare_wypozyczenia
-- ----------------------------
DROP EVENT IF EXISTS `usun_stare_wypozyczenia`;
delimiter ;;
CREATE EVENT `usun_stare_wypozyczenia`
ON SCHEDULE
EVERY '1' DAY STARTS '2023-01-01 02:00:00'
ON COMPLETION PRESERVE
DO delete from Wypozyczenie where datediff(now(), faktyczna_data_zwrotu) > 365
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table Czytelnicy
-- ----------------------------
DROP TRIGGER IF EXISTS `hash_haslo`;
delimiter ;;
CREATE TRIGGER `hash_haslo` BEFORE INSERT ON `Czytelnicy` FOR EACH ROW BEGIN
    SET NEW.haslo = SHA1(NEW.haslo);
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table Czytelnicy
-- ----------------------------
DROP TRIGGER IF EXISTS `sprawdz_login`;
delimiter ;;
CREATE TRIGGER `sprawdz_login` BEFORE INSERT ON `Czytelnicy` FOR EACH ROW BEGIN
    DECLARE login_count INT;

    -- Sprawdzanie, czy login jest już zajęty
    SELECT COUNT(*) INTO login_count FROM Czytelnicy WHERE login = NEW.login;

    IF login_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Login jest już zajęty.';
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table Czytelnicy
-- ----------------------------
DROP TRIGGER IF EXISTS `hash_haslo_update`;
delimiter ;;
CREATE TRIGGER `hash_haslo_update` BEFORE UPDATE ON `Czytelnicy` FOR EACH ROW BEGIN
    SET NEW.haslo = SHA1(NEW.haslo);
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table Wypozyczenie
-- ----------------------------
DROP TRIGGER IF EXISTS `zwieksz_wypozyczenia_czytelnika`;
delimiter ;;
CREATE TRIGGER `zwieksz_wypozyczenia_czytelnika` AFTER INSERT ON `Wypozyczenie` FOR EACH ROW BEGIN
UPDATE Czytelnicy SET liczba_wypozyczonych_ksiazek = liczba_wypozyczonych_ksiazek + 1 WHERE ID_czytelnik = new.ID_czytelnik;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table Wypozyczenie
-- ----------------------------
DROP TRIGGER IF EXISTS `zmniejsz_liczbe_sztuk`;
delimiter ;;
CREATE TRIGGER `zmniejsz_liczbe_sztuk` AFTER INSERT ON `Wypozyczenie` FOR EACH ROW BEGIN
UPDATE Ksiazki SET liczba_dostepnych_egzemplarzy = liczba_dostepnych_egzemplarzy - 1 WHERE ID_ksiazki = (SELECT ID_ksiazki FROM Egzemplarz WHERE ID_egzemplarz = new.ID_egzemplarz);
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table Wypozyczenie
-- ----------------------------
DROP TRIGGER IF EXISTS `status_egzemplarz_niedostepny`;
delimiter ;;
CREATE TRIGGER `status_egzemplarz_niedostepny` AFTER INSERT ON `Wypozyczenie` FOR EACH ROW BEGIN
UPDATE Egzemplarz SET czy_dostepny = 0 WHERE ID_egzemplarz = new.ID_egzemplarz;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table Wypozyczenie
-- ----------------------------
DROP TRIGGER IF EXISTS `zmniejsz_wypozyczenia_czytelnika`;
delimiter ;;
CREATE TRIGGER `zmniejsz_wypozyczenia_czytelnika` AFTER UPDATE ON `Wypozyczenie` FOR EACH ROW BEGIN
IF new.faktyczna_data_zwrotu IS NOT NULL THEN
	UPDATE Czytelnicy SET liczba_wypozyczonych_ksiazek = liczba_wypozyczonych_ksiazek - 1 WHERE ID_czytelnik = new.ID_czytelnik;
END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table Wypozyczenie
-- ----------------------------
DROP TRIGGER IF EXISTS `nalicz_kare`;
delimiter ;;
CREATE TRIGGER `nalicz_kare` AFTER UPDATE ON `Wypozyczenie` FOR EACH ROW BEGIN

DECLARE liczba_dni_spoznienia int default 0;
DECLARE kara DOUBLE DEFAULT 0.0;
IF new.faktyczna_data_zwrotu IS NOT NULL THEN
	IF new.spodziewana_data_zwrotu < new.faktyczna_data_zwrotu
		THEN
			SET liczba_dni_spoznienia = DATEDIFF(new.faktyczna_data_zwrotu,new.spodziewana_data_zwrotu);
			SET kara = liczba_dni_spoznienia * 0.2;
			
			INSERT INTO Kary (ID_wypozyczenie, kara_brutto) VALUES (new.ID_wypozyczenie, kara);
	END IF;
END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table Wypozyczenie
-- ----------------------------
DROP TRIGGER IF EXISTS `zwieksz_liczbe_sztuk`;
delimiter ;;
CREATE TRIGGER `zwieksz_liczbe_sztuk` AFTER UPDATE ON `Wypozyczenie` FOR EACH ROW BEGIN
IF new.faktyczna_data_zwrotu IS NOT NULL THEN
	UPDATE Ksiazki SET liczba_dostepnych_egzemplarzy = liczba_dostepnych_egzemplarzy + 1 WHERE ID_ksiazki = (SELECT ID_ksiazki FROM Egzemplarz WHERE ID_egzemplarz = new.ID_egzemplarz);
END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table Wypozyczenie
-- ----------------------------
DROP TRIGGER IF EXISTS `status_egzemplarz_dostepny`;
delimiter ;;
CREATE TRIGGER `status_egzemplarz_dostepny` AFTER UPDATE ON `Wypozyczenie` FOR EACH ROW BEGIN
IF new.faktyczna_data_zwrotu IS NOT NULL THEN
	UPDATE Egzemplarz SET czy_dostepny = 1 WHERE ID_egzemplarz = new.ID_egzemplarz;
END IF;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
