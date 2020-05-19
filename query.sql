\*
  1. Mostrare nome e descrizione di tutti i moduli da 9 CFU
*\
SELECT nome, descrizione
FROM modulo
WHERE cfu = 9;

\*
  2. Mostrare matricola, nome e cognome dei docenti che hanno più di 60 anni
*\
SELECT matricola, nome, cognome
FROM docente
WHERE data_nascita < ‘1960-01-01’;

\*
  3. Mostrare nome, cognome e nome del dipartimento di ogni docente, ordinati dal più giovane al più anziano.*\
SELECT nome, cognome, dipartimento
FROM docente
ORDER BY data_nascita;

\*
  4. Mostrare città e indirizzo di ogni sede del dipartimento di codice "uniba"
*\
SELECT citta, indirizzo
FROM sede
WHERE codice=‘uniba’;

\*
  5. Mostrare nome del dipartimento, città e indirizzo di ogni sede di ogni dipartimento, ordinate alfabeticamente prima per nome dipartimento, poi per nome città e infine per indirizzo.
*\

\*
	5.1 ordina per nome
*\
select D.nome, S.citta, S.indirizzo  
from sede as S join sede_dipartimento as SD on S.codice=SD.codice_sede JOIN dipartimento as D on SD.codice_dipartimento=D.codice
ORDER BY D.nome;

\*
	ordina per citta
*\
select D.nome, S.citta, S.indirizzo  
from sede as S join sede_dipartimento as SD on S.codice=SD.codice_sede JOIN dipartimento as D on SD.codice_dipartimento=D.codice
ORDER BY S.citta;

\*
	ordina per indirizzo
*\
select D.nome, S.citta, S.indirizzo  
from sede as S join sede_dipartimento as SD on S.codice=SD.codice_sede JOIN dipartimento as D on SD.codice_dipartimento=D.codice
ORDER BY S.indirizzo;


\*
  6.  Mostrare il nome di ogni dipartimento che ha una sede a Bari.
*\
SELECT D.nome
FROM sede as S JOIN sede_dipartimento as SD on S.codice = SD.codice_dipartimento JOIN dipartimento as D on SD.codice_dipartimento=D.codice
WHERE S.citta = ‘bari’;

\*
 7. Mostrare il nome di ogni dipartimento che non ha sede a bari.*\
SELECT D.nome 
FROM sede as S JOIN sede_dipartimento as SD on S.codice = SD.codice_sede JOIN dipartimento as D on SD.codice_dipartimento = D.codice 
WHERE not exists (SELECT codice FROM sede WHERE citta='bari';


\*
 8. Mostrare media, numero esami sostenuti e totale CFU acquisiti dello studente con matricola 123456.
*\
SELECT avg(voto), count(matricola_studente), sum(M.cfu) 
FROM esame JOIN modulo as M on codice_modulo=M.codice 
WHERE matricola_studente=‘123456';

\*
 9. Mostrare nome, cognome, nome del corso di laurea, media e numero esami sostenuti dello studente con matricola 123456.
*\
SELECT S.nome, S.cognome, avg(voto), count(matricola_studente),CL.nome as corso_di_laurea 
FROM studente as S JOIN corso_laurea as CL on S.corso_laurea=CL.codice JOIN esame on S.matricola=matricola_studente JOIN modulo as M on codice_modulo=M.codice  
WHERE matricola_studente='123456';


\*
 10. Mostrare codice, nome e voto medio di ogni modulo, ordinati dalla media più alta alla più bassa.
.*\
SELECT E.codice_modulo, avg(E.voto) as voto_medio, M.nome as modulo 
FROM esame AS E JOIN modulo as M on E.codice_modulo=M.codice 
GROUP BY E.codice_modulo,M.nome 
ORDER BY avg(E.voto) DESC;

\*
 11. Mostrare nome e cognome del docente, nome e descrizione del modulo per ogni docente ed ogni modulo di cui quel docente abbia tenuto almeno un esame; il risultato deve includere anche i docenti che non abbiano tenuto alcun esame, in quel caso rappresentati con un'unica tupla in cui nome e descrizione del modulo avranno valore NULL.
.*\
SELECT D.nome, D.cognome, M.nome as nome_modulo, M.descrizione 
FROM docente as D LEFT OUTER JOIN esame as E on D.matricola=E.matricola_docente LEFT OUTER JOIN modulo as M on E.codice_modulo = M.codice;

\*
 12. Mostrare matricola, nome, cognome, data di nascita, media e numero esami sostenuti di ogni studente.
.*\
SELECT S.nome, S.cognome, S.matricola, S.data_nascita, avg(E.voto) as media_studente, count(E.matricola_studente) as esami_sostenuti 
FROM studente as S JOIN esame as E on S.matricola=E.matricola_studente 
GROUP BY S.nome,S.cognome,S.matricola;

\*
 13. Mostrare matricola, nome, cognome, data di nascita, media e numero esami sostenuti di ogni studente.
.*\
SELECT S.nome, S.cognome, S.matricola, S.data_nascita, avg(E.voto) as media_studente, count(E.matricola_studente) as esami_sostenuti  
FROM studente as S JOIN esame as E on S.matricola=E.matricola_studente  
WHERE S.corso_laurea='ICD' GROUP BY S.nome,S.cognome,S.matricola 
HAVING avg(E.voto) > 27;

\*
 14. Mostrare nome, cognome e data di nascita di tutti gli studenti che ancora non hanno superato nessun esame.
.*\
SELECT distinct S.nome, S.cognome, S.data_nascita 
FROM studente as S LEFT OUTER JOIN esame as E on S.matricola=E.matricola_studente 
WHERE E.codice_modulo IS NULL;

\*
 15. Mostrare la matricola di tutti gli studenti che hanno superato almeno un esame e che hanno preso sempre voti maggiori di 26.
.*\
SELECT distinct S.nome, S.cognome, S.data_nascita 
FROM studente as S LEFT OUTER JOIN esame as E on S.matricola=E.matricola_studente 
WHERE E.codice_modulo IS NOT NULL 
GROUP BY S.nome,S.cognome, S.data_nascita 
HAVING avg(E.voto) > 26;






