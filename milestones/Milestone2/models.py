"""
In this file you must implement all your database models.
If you need to use the methods from your database.py call them
statically. For instance:
       # opens a new connection to your database
       connection = Database.connect()
       # closes the previous connection to avoid memory leaks
       connection.close()
"""

from database import Database, Query


class TestModel:
    """
    This is an object model example. Note that
    this model doesn't implement a DB connection.
    """

    def __init__(self, ctx):
        self.ctx = ctx
        self.author = ctx.message.author.name

    def response(self,ctx):
      print(ctx)
      return f'Hi, {self.author} {ctx[0]}. I am alive'
      
    #command 1
    def getInfo(self,userId):
      response = ""
      results = ''
      db = Database()
      sql= Query.GET_USER_INFO
      results = db.select(sql,userId)
        #Example !getUserInfo 2
      if len(results) > 0:
        for i in results:
          response = "First Name:\t"+i['first_Name'] +"\n"
          response += "Last Name:\t"+i['last_Name'] +"\n"
          response += "Role:\t\t" +i['role_Name'] + "\n"
          response += "Project:\t"+i['project_Name'] +"\n" 
        # print(results)

      else:
        response = "No Results"
      return response 

  
    #command 2
      # Get project Id 
    def getPD(self,projID):
      response = ""
      results = ''
      db = Database()
      
      sql =Query.GET_PROJ_ID
      results = db.select(sql,projID[0])
      # Example !getProjectDetails 2
      if len(results) > 0:
        for i in results:
          response = "Project Name:\t"+i['project_Name'] +"\n"
          response += "Project Lead:\t"+i['first_Name'] +"\n"
          response += "Role:\t\t" +i['researcher_expertise'] + "\n" 
          response += "Publication Title:\t"+i['title'] +"\n" 
  
        print(results)
  
      else:
        response = "No Results"
      return response

  
    #command 3
    # Setting new Equipment 
    def setEQ(self,projID):
      response = ""
      results = ''
      db = Database()
      sql= Query.SET_NEW_EQUIP
      # print(projID[0],projID[1] ,projID[2],projID[3])
      results = db.insert(sql,projID,True,4)
    #Example: !insertEquipment Microscope "Weekly checkup" true 2 
      if results > 0:
        response = f"{self.author} Insert has been executed!"
      else:
        response = f"{self.author} Error with Insertion, try again!"
      return response
      
    

    #command 4
      # Get Submit Proposition 
    def enterProp(self,projID):
      response = ""
      results = ''
      db = Database()
      sql= Query.SUBMIT_PROP
      results = db.insert(sql,projID,True,2)
      #Example: !submitProposal 2 "Exploring Genetic Variations"
      if results > 0:
        response = f"{self.author} Propotion has been added!"
      else:
        response = f"{self.author} Error with Proposition, try again!"
      return response
      
   
      
    #command 5
      # Update lab 
    def updateLab(self,projID):
      response = ""
      results = ''  
      db = Database()
      sql= Query.UPDATE_LAB
      results = db.insert(sql,projID,True,3)
      #Example: !updateLabInfo 1 "Advanced Genetics Lab1" 50
      
      if  (results) > 0:
        response = f"{self.author} Lab has been Set!"
      else:
        response = f"{self.author} Error with Lab, try again!"
      return response
       

  #command 6
    def updateRA(self,projID):
      response = ""
      results = ''
      db = Database()
      sql= Query.UPDATE_RA
      results = db.update(sql,projID,1)
      #Example: !updateResearcherAffiliation 2 "Biotech Innovators"
      if results > 0:
        response = f"{self.author} Update has been added!"
      else:
        response = f"{self.author} Error with Update, try again!"
      return response
    
      
    #command 7
    def deleteER(self,projID):
      response = ""
      results = ''
      db = Database()
      sql= Query.DELETE_ER
      results = db.delete(sql,projID,404)
      #Example:!deleteExperimentResult 1
      if results > 0:
        response = f"{self.author} Delete has been executed!"
      else:
        response = f"{self.author} Error with Delete, try again!"
      return response

    
    #command 8
    def deleteLAR(self,projID):
      response = ""
      results = ''
      db = Database()
      sql= Query.DELETE_LAR
      results = db.delete(sql,projID,404)
      #Example:!deleteLabAccessRequest 2

      if results > 0:
        response = f"{self.author} Delete has been executed!"
      else:
        response = f"{self.author} Error with Delete, try again!"
      return response
    
    #command 9
    def getSR(self,projID):
      response = ""
      results = ''
      db = Database()
      sql= Query.GET_SR
      results = db.select(sql,projID,True)
      #Example:!getStoredResults 1
    
      if len(results) > 0: 
        for i in results:
          response = "Request Id:\t"+str(i['request_id'])+"\n"
          response += "Status:\t" +i['status'] + "\n" 
          response += "Access lvl:\t"+str(i['access_Level']) +"\n" 
          response += "Request Description:\n--> "+i['request_description'] +"\n"
       # print(results)

      else:
        response = "No Results"
      return response
      

  
      #command 10
    def getPF(self,projID):
      response = ""
      results = ''
      db = Database()
      sql= Query.GET_PF
      results = db.select(sql,projID,True)
      #Example: !getProjectFunding 1
      if len(results) > 0: 
        for i in results:
          response = "Funding Id:\t"+str(i['fk_projectId'])+"\n"
          response += "Amount:\t\t" +str(i['funding_Amount']) + "\n" 
      else:
        response = "No Results"
     
      return response

    #command 11
      # Update Maintence log 
    def updateML(self,projID):
      response = ""
      results = ''
      db = Database()
      sql= Query.UPDATE_ML
      results = db.update(sql,projID,1)
      #Example: !updateMaintenanceLog 2 "NEW LOG"
      
      if results > 0:
        response = f"{self.author} Update has been added!"
      else:
        response = f"{self.author} Error with Update, try again!"
      return response

  #command 12
    # Insert Sample 
    def insertSample(self,projID):
      response = ""
      results = ''
      db = Database()
      sql= Query.INSERT_SAMPLE
      results = db.insert(sql,projID,True,3)
      #Example: !insertSample 1 discordSample "Testing the sample"
    
      if results > 0:
        response = f"{self.author} Sample has been added!"
      else:
        response = f"{self.author} Error with Sample, try again!"
      return response
      
      #command 13
        # Get Sample
    def getSample(self,projID):
      response = ""
      results = ''
      db = Database()
      sql= Query.GET_SAMPLE
      results = db.select(sql,projID,True)
      #Example: !getSample 1
      
      if len(results) > 0:
          for i in results:
            response = "Sample Name:\t"+str(i['sample_Name'])+"\n"
            response += "Location:\t\t" +i['storage_Location'] +"\n" 
            response += "Description:\t"+str(i['description']) +"\n" 
      else:
          response = "No Results"
      return response

    #command 14
      # Retrieve Collaboration count
    def getCC(self,projID):
      response = ""
      results = ''
      db = Database()
      sql= Query.GET_CC
      results = db.select(sql,projID,True)
     # Example: !getCollaboratorCount 1
      
      if len (results) > 0:
          for i in results:
            response = "Number Participants:\t"+str(i['number_Participants'])+"\n"
            response += "Location:\t\t" +str(i['collaboration_Date']) +"\n" 
      else:
          response = "No Results"
      return response


  #command 15
    # Retrieve Sample ID
    def genSI(self,projID):
      response = ""
      results = ''

      results = self.getSample(projID)
     # Example: !generateSampleID 2
      response = results
      return response
