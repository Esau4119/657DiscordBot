   -- Script name: inserts.sql
   -- Author:      Esau B. Medina SFSU ID #921207336
   -- Purpose:     insert sample data to test the integrity of this database system
   
     -- the database used to insert the data into.
      USE biotech_researchdb;
      -- hi pt2
INSERT INTO users (first_name, last_Name) 
	VALUES
	( 'Alice', 'WonderLand'),
	( 'Bob', 'TheBuilder'),
	('Dora', 'Explora');      
INSERT INTO labs(lab_Name,manager_Id,location,max_Capacity)
	VALUES
	('Lab A', 1, 'Building 1, Room 101', 30),
	('Lab B', 2, 'Building 2, Room 202', 25),
	('Lab C', 3, 'Building 3, Room 303', 40);

INSERT INTO equipment (equimpent_Name, maintenance_schedule , maintenance_Log,is_available, fk_LabId)
	VALUES  
	('Microscope', 'Monthly maintenance schedule', 'Performing routine cleaning and calibration.', 1, 1),
	('Telescope', 'Quarterly maintenance schedule', 'Checking optics and tracking system.', 1, 2),
	('X-ray machine', 'Bi-annual maintenance schedule', 'Inspecting radiation shielding and power supply.', 0, 3);
    
INSERT INTO projects(project_Name,project_Description,start_Date,endt_Date,project_Lead_Id)
	VALUES
	('Biotech Project A', 'Research on genetic modification of crops', CURDATE(), '2024-04-01', 1),
	('Biotech Project B', 'Development of a new drug for cancer treatment', CURDATE(),  '2024-06-15', 2),
	('Biotech Project C', 'Stem cell research for regenerative medicine', CURDATE(),  '2024-07-10', 3);
    
INSERT INTO sample(`sample_Name`,`description`,`storage_Location`,`fk_projectId`)
	VALUES
	('Sample A', 'Tissue sample from a genetically modified mouse', 'Freezer Unit 1, Rack 3, Shelf 2', 1),
	('Sample B', 'Serum sample for drug testing', 'Cold Storage Room 2, Shelf 1', 2),
	('Sample C', 'Plant samples for biopharmaceutical research', 'Lab Refrigerator 3, Shelf 3', 3);
	 
INSERT INTO experiments(experiment_date, experiment_Description,fk_sampleId,fk_labId)
	VALUES
	( CURDATE(),'Gene Expression Analysis',1,1),
	( CURDATE(), 'Protein Assay',2,2),
	( CURDATE(),'Cell Viability Test',2,2);

 INSERT INTO experimentresults (fk_ExperimentId,experiment_description)
	VALUES  
	(1,'Average gene expression levels for genes A, B, and C in sample SMP-001 were measured as follows: Gene A: 3.2, Gene B: 5.1, Gene C: 2.4.'),
	(2,'The protein concentration in sample PRT-005 was determined to be 25 µg/mL using the Bradford protein assay method.'),
	(3,'Cell viability assay results for sample CVT-012: 95% viability after 24 hours of treatment with drug X.');
 
INSERT INTO gene (gene_Name, sequence,fk_sampleId)
	VALUES
	('GeneA', 'ATGCTAGTCTAGCGTAGCGTAGCTAGCTAGCTAGCTAGCTAGCTAGCTAGCTAGCTAGCTA',1),
	( 'GeneB', 'ATGCGTAGCTAGCTAGCTAGCTAGCTAGCTAGCTAGCTAGCTAGCTAGCTAGCTAGCTAGT',2),
	( 'GeneC', 'ATGCATGCATGCATGCATGCATGCATGCATGCATGCATGCATGCATGCATGCATGCATGCAT',3);

INSERT INTO labaccessrequest(request_description,status,access_Level,fk_labId)
	VALUES
	('Request for access to Lab A', 'Pending', 2,1),
	('Access request for Lab B', 'Approved', 3,2),
	('Lab Access Request for Lab C', 'Rejected', 1,3);

INSERT INTO labs(lab_Name,manager_Id,location,max_Capacity)
	VALUES
	('Lab A', 1, 'Building 1, Room 101', 30),
	('Lab B', 2, 'Building 2, Room 202', 25),
	('Lab C', 3, 'Building 3, Room 303', 40);

INSERT INTO fundingsource(source_Name, contact_Info)
	VALUES
	('Funding Foundation 1','415-111-1110'),
	('Funding Foundation 2','415-111-1110'),
	('Funding Foundation 3','415-111-1110');

INSERT INTO projectfunding(fk_projectId, fk_sourceId, funding_Amount)
	VALUES
	(1,1,1000),
	(2,2,500),
	(3,3,200);

INSERT INTO publication(title, publication_Date, DOI,fk_projectId) 
	VALUES 
	('Research Paper 1', CURDATE(), '10.1234/abcd123', 1),
	('Scientific Article 2', CURDATE(),'10.5678/efgh456', 2),
	('Journal Article 3', CURDATE(), '10.9012/ijkl789', 3);


INSERT INTO publicationauthor(author_name,affiliation,fk_projectLeadId,fk_publicationId)
	VALUES
	('John Doe', 'Biotech Institute A', 1, 1),
	('Jane Smith', 'Biotech Research Lab B', 2, 2),
	('Michael Johnson', 'Genetics Research Center', 3, 3);
    
    
INSERT INTO researcher(fk_researcher_Id,fk_researcherName,affiliation,researcher_expertise)
	VALUES
	(1, 'Alice', 'Biotech Institute A', 'Genetic Engineering'),
	(2, 'Bob', 'Biotech Research Lab B', 'Drug Discovery'),
	(3, 'Dora', 'Genetics Research Center', 'Stem Cell Research');


INSERT INTO researchproposal(proposal_description,status,fk_researcherId)
	VALUES
	('Study on the effects of gene editing in mice', 'Submitted', 1),
	('Development of a new vaccine for viral diseases', 'In Progress', 2),
	('Investigation of plant-based biopharmaceuticals', 'Approved', 3);


INSERT INTO role(`role_Name`,`role_Permissions`,`fk_userId`)
	VALUES
	('Researcher', 'Read', 1),
	('Lab Technician', 'Read, Write', 2),
	('Project Manager', 'Read, Write, Approve', 3);

INSERT INTO sampleresults(`analysis_description`,`fk_sampleId`)
	VALUES
	('Genetic analysis of Sample A', 1),
	('Drug testing results for Sample B', 2),
	('Biochemical analysis of Sample C', 3);

INSERT INTO collaboration (collaboration_Date, number_Participants,fk_researchertId) 
	VALUES 
	( CURDATE(), 2, 1),
	( CURDATE(), 1, 2),
	(CURDATE(), 3, 3);
