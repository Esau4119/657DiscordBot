  # In this file you must implement your main query methods 
  # so they can be used by your database models to interact with your bot.
import os
from pymysql import err

import pymysql.cursors

  # note that your remote host where your database is hosted
  # must support user permissions to run stored triggers, procedures and functions.
db_host = os.environ["DB_HOST"]
db_username = os.environ["DB_USER"]
db_password = os.environ["DB_PASSWORD"]
db_name = os.environ["DB_NAME"]


class Database:
      @staticmethod
      def connect(bot_name):
          """ 
          This method creates a connection with your database
          IMPORTANT: all the environment variables must be set correctly
                     before attempting to run this method. Otherwise, it
                     will throw an error message stating that the attempt
                     to connect to your database failed.
          """
          try:
              conn = pymysql.connect(host=db_host,
                                     port=3306,
                                     user=db_username,
                                     password=db_password,
                                     db=db_name,
                                     charset="utf8mb4", cursorclass=pymysql.cursors.DictCursor)
              print("Bot {} connected to database {}".format(db_name,bot_name))
              return conn
          except ConnectionError as err:
              print(f"An error has occurred: {err.args[1]}")
              print("\n")

  
      def get_response(self, query, values=None, fetch=False, many_entities=False,dif=0):
          """
          query: the SQL query with wildcards (if applicable) to avoid injection attacks
          values: the values passed in the query
          fetch: If set to True, then the method fetches data from the database (i.e with SELECT)
          many_entities: If set to True, the method can insert multiple entities at a time.
          """
          response = ""
          results = ''
        
          #Select: 
          if fetch is True:
            try:
              connection = Database.connect(self)
              if connection:
                cursor = connection.cursor()
                cursor.execute(query, (int(values[0]),))
                response = cursor.fetchall()
                print(len(response))
            except Exception as e:
              print(e)
              response = ""
            finally:
              connection.close()
              
              
          #Insert
          if many_entities is True and dif == 4:
            print(type(int(values[3])))
            try:
              connection = Database.connect(self)
              if connection:
                cursor = connection.cursor()
                cursor.execute(query, (int(values[0]),values[1],values[2],values[3]))
                connection.commit()
                print("rows affected: "+str (connection.affected_rows()))
                response = connection.affected_rows()
            except Exception as e:
                response = 0
                print(e)
            finally:
                connection.close()
              
          if many_entities is True and dif == 3:
              try:
               
                connection = Database.connect(self)
                if connection:
                  cursor = connection.cursor()
                  cursor.execute(query, (values[1],values[2],values[0]))
                  connection.commit()
                  print("rows affected: "+str (connection.affected_rows()))
                  response = connection.affected_rows()
              except Exception as e:
                  response = 0
                  print(e)
              finally:
                connection.close()
              return response
            
          if many_entities is True and dif == 2:
         
            try:
              connection = Database.connect(self)
              if connection:
                cursor = connection.cursor()
                cursor.execute(query, (int(values[0]),values[1]))
                connection.commit()
                print("rows affected: "+str (connection.affected_rows()))
                response = connection.affected_rows()
            except Exception as e:
              response = 0
              print(e)
            finally:
              connection.close()
              
          #Delete
          if dif == 404:
            print("hi in Delete", int(values[0]))
            try:
              connection = Database.connect(self)
              if connection:
                cursor = connection.cursor()
                cursor.execute(query, (int(values[0]),))
                connection.commit()
                print("rows affected: "+str (connection.affected_rows()))
                response = connection.affected_rows()
            except Exception as e:
                response = 0
                print(e)
            finally:
              connection.close()
            #Update
          if dif == 1:
            try:
              connection = Database.connect(self)
              if connection:
                cursor = connection.cursor()
                cursor.execute(query,(values[1],int(values[0])))
                connection.commit()
                response = cursor.fetchall()
                print("rows affected: "+str (connection.affected_rows()))
                response = connection.affected_rows()
            except Exception as e:
                response = 0
                print(e)
            finally:
              connection.close()
  
          return response
        

      @staticmethod
      def select(query,values=None, fetch=True):
          database = Database()
          return database.get_response(query, values=values, fetch=fetch)

      @staticmethod
      def insert(query, values=None, many_entities=False, dif=0):
          database = Database()
          return database.get_response(query, values=values, many_entities=many_entities,dif=dif)

      @staticmethod
      def update(query, values=None,dif=0):
          database = Database()
          return database.get_response(query, values=values,dif=dif)

      @staticmethod
      def delete(query, values=None,dif=0):
          database = Database()
          return database.get_response(query, values=values,dif=dif)


class Query:   
  GET_USER_INFO = """SELECT u.first_Name,u.last_Name, r.role_Name, p.project_Name
                      FROM Role r
                      JOIN Users u ON r.fk_userId = u.user_Id
                      LEFT JOIN Projects p ON p.project_Lead_Id = u.user_Id
                      WHERE u.user_Id = %c;
                  """
  GET_PROJ_ID = """SELECT * FROM Projects p
                     LEFT JOIN Users u ON p.project_Lead_Id = u.user_Id
                     LEFT JOIN Researcher r ON r.fk_researcher_Id = u.user_Id
                     LEFT JOIN Publication pub ON pub.fk_projectId = p.project_Id
                     WHERE p.project_Id = %c;
                  """
  SET_NEW_EQUIP= """INSERT INTO Equipment (equimpent_Name, maintenance_schedule,
                     is_available, fk_LabId)VALUES (%s, %s, %s, %s);
                  """
  SUBMIT_PROP ="""INSERT INTO ResearchProposal (fk_researcherId, proposal_description,
                    status) VALUES (%s, %s, 'Pending');

                """
  UPDATE_LAB  = """ UPDATE Labs SET lab_Name = %s, max_Capacity = %s
                      WHERE lab_Id = %s
                """
  UPDATE_RA   = """ UPDATE Researcher SET affiliation = %s 
                      WHERE fk_researcher_Id = %s;
                """
  DELETE_ER   = """ DELETE FROM ExperimentResults WHERE fk_ExperimentId = %s;
                """
  DELETE_LAR   = """ DELETE FROM LabAccessRequest WHERE request_id = %s;
                """
  GET_SR      = """ SELECT * FROM LabAccessRequest WHERE request_id = %s;
                """
  GET_PF      = """ SELECT * FROM ProjectFunding WHERE fk_projectId = %s;
      """
  UPDATE_ML   = """ UPDATE Equipment
                      SET maintenance_Log = %s
                      WHERE equipment_Id = %s;
                """
  INSERT_SAMPLE=""" INSERT INTO Sample (sample_Name, description,fk_projectId)
                      VALUES (%s, %s, %s);
                """
  GET_SAMPLE =  """SELECT * FROM Sample WHERE sample_Id = %s;
                """
  GET_CC     ="""SELECT * FROM Collaboration
       WHERE fk_researchertId = %s;
      """
