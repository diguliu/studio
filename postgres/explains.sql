1
EXPLAIN ANALYZE SELECT member_id FROM band_has_member WHERE band_login = 'led_zeppelin';
2
EXPLAIN ANALYZE SELECT * FROM agenda_has_equipment WHERE equipment_id = 9;
3
EXPLAIN ANALYZE SELECT * FROM client_rents_equipment WHERE equipment_id = 9;

4
Retorna o nome, a idade e o sexo das pessoas e a banda à qual ela pertence.
EXPLAIN ANALYZE SELECT p.name, p.age, p.gender, b.name 
FROM person AS p 
INNER JOIN member AS m ON p.cpf = m.person_cpf 
INNER JOIN band_has_member AS bhm ON m.member_id = bhm.member_id 
INNER JOIN band AS b ON bhm.band_login = b.login 
WHERE p.age < 25 AND p.gender = 'male';
