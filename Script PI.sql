/*Entregable segundo parcial BD Proyecto Integrador*/

#Vista  1 
/*En esta vista se relaciona el animal en peligro de extinción con su hábitat
y su estatus de conservaciión*/
CREATE VIEW Animals_has_Habitat AS
	SELECT 
		a.common_name AS Animal,
		h.name AS Hábitat,
		hc.name AS Estatus_Conservacion_Habitats
	FROM 
		animals AS a
	JOIN 
		animals_habitats ah ON a.id = ah.animal_id
	JOIN 
		habitats h ON ah.habitat_id = h.id
	JOIN
		habitat_conservation_status  hc ON h.id_habitat_conservation_status = hc.id;
        
#VISTA 2  
/*En esta vista nos da información acerca de las especies e información especifica de dicha especie*/

CREATE VIEW Info_species AS
SELECT 
	s.scientific_name, 
	s.description AS species_description, 
	s.life_expectacy,
	a.common_name AS animal, 
	f.name AS feeding, 
	sc.name AS conservation_status
FROM 
	species s
JOIN 
	animals a ON s.animal_id = a.id
JOIN 
	feedings f ON s.feeding_id = f.id
JOIN 
	species_conservation_status sc ON s.specie_conservation_status = sc.id;
    
#Vista 3
CREATE VIEW Contacts_associations AS
SELECT 
    ci.contact,
    contact_types.name AS Contact_type,
    associations.name AS Asociation
FROM
	contact_information ci
JOIN
	associations ON ci.id = associations.id
JOIN
	contact_types ON ci.id = contact_types.id;


/*-----------------------------------------------------------------------------------------------------------*/	
/*------------------- PROCEDIMIENTO ALMACENADO --------------------------------------------------------------*/
/*-----------------------------------------------------------------------------------------------------------*/

-- PROCEDIMIENTO ALMACENADO 1 
DELIMITER //

CREATE PROCEDURE sp_InsertarAnimalYHabitat (
    IN commonName VARCHAR(100),
    IN scientificName VARCHAR(100),
    IN description LONGTEXT,
    IN estimatedPopulation INT,
    IN habitatID INT
)
BEGIN

    DECLARE lastAnimalID INT;

    INSERT INTO animals (common_name, scientific_name, description, estimated_population)
    VALUES (commonName, scientificName, description, estimatedPopulation);

    SET lastAnimalID = LAST_INSERT_ID();

    INSERT INTO animals_habitats (animal_id, habitat_id)
    VALUES (lastAnimalID, habitatID);
END//

DELIMITER ;

-- Ejemplos de uso:
 CALL sp_InsertarAnimalYHabitat('Tigre', 'Panthera tigris', 'Grande Felino Carnivoro', 3900, 4);
 CALL sp_InsertarAnimalYHabitat('Elefante', 'Loxodonta africana', 'Los elefantes son los animales terrestres más grandes.
 Tienen una piel gruesa y rugosa, grandes orejas que les ayudan a regular su temperatura, y colmillos largos y curvados. 
 Viven en grupos matriarcales y tienen una dieta herbívora', 415000, 4);
 
 ----- ejemplo 2
 
 DELIMITER //

CREATE PROCEDURE sp_ActualizarAnimalDescription(
    IN animalID INT,
    IN newDescription LONGTEXT
)
BEGIN
    UPDATE animals
    SET description = newDescription
    WHERE id = animalID;
END //

DELIMITER ;
-- ejecucion proceso almacenado 2
CALL sp_ActualizarAnimalDescription(1, 'El Lince es un mamifero carnivoro.');
CALL sp_ActualizarAnimalDescription(2, 'La tortuga es color verde.');

DELIMITER //

-- ejercicio 3
DELIMITER //

CREATE PROCEDURE sp_BorrarAnimal(
    IN animalID INT
)
BEGIN
    -- Primero eliminar las referencias en animals_habitats
    DELETE FROM animals_habitats WHERE animal_id = animalID;
    
    -- Luego eliminar el registro principal en animals
    DELETE FROM animals WHERE id = animalID;
    
END //

DELIMITER ;

-- Llamar al procedimiento almacenado para borrar el animal con ID 6
CALL sp_BorrarAnimal(6);


-- Llamar al procedimiento almacenado para borrar el animal con ID 7
CALL sp_BorrarAnimal(1);

-- EJERCICIO 4
DELIMITER //
CREATE PROCEDURE sp_InsertarAmenazaYTipo (
    IN threatName VARCHAR(100),
    IN threatDescription LONGTEXT,
    IN threatTypeName VARCHAR(100),
    IN threatTypeDescription LONGTEXT
)
BEGIN

    DECLARE lastThreatTypeID INT;

    INSERT INTO threat_types (name, description)
    VALUES (threatTypeName, threatTypeDescription);

    SET lastThreatTypeID = LAST_INSERT_ID();

    INSERT INTO threats (name, description, id_threat_type)
    VALUES (threatName, threatDescription, lastThreatTypeID);
END//
DELIMITER ;
-- Ejemplos de uso:
CALL sp_InsertarAmenazaYTipo('Caza furtiva', 'Caza ilegal', 'Actividad humana', 'Actividades que causan daño directo a las especies');
CALL sp_InsertarAmenazaYTipo('Deforestación', 'Tala de bosques', 'Ambiental', 'Alteración a gran escala de los ecosistemas');


-- EJEMPLO 5
DELIMITER //
CREATE PROCEDURE sp_ActualizarHabitatConservationStatus(
    IN habitatID INT,
    IN newConservationStatusID INT
)
BEGIN
    UPDATE habitats
    SET id_habitat_conservation_status = newConservationStatusID
    WHERE id = habitatID;
END //

DELIMITER ;
-- EJEMPLO DE USO
CALL sp_ActualizarHabitatConservationStatus(1, 5);

/*---------------------------------------------------------------------------------------------------------------------------*/
/*TRANSACCIONES-------------------------------------------------------------------------------------------------------------*/
/*-------------------------------------------------------------------------------------------------------------------------*/
DELIMITER //

CREATE PROCEDURE sp_RegistrarUsuarioYAsignarRol(
    IN p_name VARCHAR(100),
    IN p_lastname1 VARCHAR(100),
    IN p_lastname2 VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_password VARCHAR(100),
    IN p_birthdate DATE,
    IN p_roleID INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Error al registrar usuario y asignar rol';
    END;

    START TRANSACTION;

    INSERT INTO users (name, lastname_1, lastname_2, email, password, birthdate, id_roles)
    VALUES (p_name, p_lastname1, p_lastname2, p_email, p_password, p_birthdate, p_roleID);

    SET @lastUserID = LAST_INSERT_ID();

    COMMIT;
END //
DELIMITER ;
-- Ejemplo de ejecucion proceso con transaccion 
CALL sp_RegistrarUsuarioYAsignarRol('John', 'martinez', 'zarate', 'john.doe@example.com', 'password123', '1990-05-15', 2);

-- TRANSACCIÓN 2
DELIMITER //

CREATE PROCEDURE sp_ActualizarEstadoImplementacionYAsociarMedidaPrevencion(
    IN p_preventionMeasureID INT,
    IN p_newImplementationStatusID INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Error al actualizar estado de implementación y asociar medida de prevención';
    END;

    START TRANSACTION;

    -- Actualizar el estado de implementación de la medida de prevención
    UPDATE prevention_measures
    SET implementation_status_id = p_newImplementationStatusID
    WHERE id = p_preventionMeasureID;

    -- Asociar la medida de prevención a todas las asociaciones
    INSERT INTO associations_prevention_measures (asociation_id, prevention_measures_id)
    SELECT id, p_preventionMeasureID FROM associations;

    COMMIT;
    SELECT 'Estado de implementación actualizado y medida de prevención asociada exitosamente.';
END //
DELIMITER //
-- EJECUCIÓN TRANSACCION 2
CALL sp_ActualizarEstadoImplementacionYAsociarMedidaPrevencion(1, 3);
DELIMITER //
-- TRANSACCION 3
CREATE PROCEDURE sp_CreateSpeciesAndAssociateAnimal(
    IN p_ScientificName VARCHAR(100),
    IN p_Description LONGTEXT,
    IN p_LifeExpectancy INT,
    IN p_FeedingID INT,
    IN p_SpeciesConservationStatusID INT,
    IN p_AnimalID INT
)
BEGIN
    DECLARE v_SpeciesID INT;
    DECLARE v_AnimalName VARCHAR(100);
    DECLARE v_SpeciesName VARCHAR(100);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Error: No se pudo crear la especie y asociarla al animal.';
    END;

    START TRANSACTION;

    INSERT INTO species (scientific_name, description, life_expectacy, animal_id, feeding_id, specie_conservation_status)
    VALUES (p_ScientificName, p_Description, p_LifeExpectancy, p_AnimalID, p_FeedingID, p_SpeciesConservationStatusID);

    SET v_SpeciesID = LAST_INSERT_ID();

    INSERT INTO species_associations (specie_id, association_id)
    VALUES (v_SpeciesID, (SELECT association_id FROM associations WHERE name = 'Animal'));

    SELECT common_name INTO v_AnimalName
    FROM animals
    WHERE id = p_AnimalID;

    SELECT scientific_name INTO v_SpeciesName
    FROM species
    WHERE id = v_SpeciesID;

    COMMIT;
END //
DELIMITER ;

CALL sp_CreateSpeciesAndAssociateAnimal('Panthera leo', 'La pantera leon pertenece a la familia Felidae.', 15, 1, 1, 1);

