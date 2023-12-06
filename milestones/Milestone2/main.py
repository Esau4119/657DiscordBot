"""
The code below is just representative of the implementation of a Bot. 
However, this code was not meant to be compiled as it. It is the responsability 
of all the students to modifify this code such that it can fit the 
requirements for this assignments.
"""
import os
import discord
from discord.ext import commands
from database import Database
from models import *


TOKEN = os.environ['DISCORD_TOKEN']

intents = discord.Intents.all()

bot = commands.Bot(command_prefix='!', intents=discord.Intents.all())

@bot.event
async def on_ready():
    print(f"Bot {bot.user} has joined the room")
    Database.connect(bot.user)

@bot.command(name="test", description="write your database business requirement for this command here")
async def _test(ctx, arg1):
    testModel = TestModel(ctx)
    response = testModel.response(arg1)
    await ctx.send(response)


# TODO: complete the following tasks:
#       (1) Replace the commands' names with your own commands
#       (2) Write the description of your business requirement in the description parameter
#       (3) Implement your commands' methods.

@bot.command(name="getUserInfo",
      description="Retrieve detailed information about a specific user")
async def _getUserInfo(ctx,*arg1):
  testModel = TestModel(ctx)
  getInfo = testModel.getInfo(arg1)
  await ctx.send(getInfo)


@bot.command(name="getProjectDetails", description="Retrieve project details, including project lead, researchers, and publications.")
async def _getPD(ctx, *args):
  testModel = TestModel(ctx)
  getPD = testModel.getPD(args)
  await ctx.send(getPD)


@bot.command(name="insertEquipment", description="Insert new equipment records with relevant details.")
# Example: !insertEquipment Microscope "Weekly checkup" true 789 
async def _setNEWEQ(ctx, *args):
  testModel = TestModel(ctx)
  setEQs = testModel.setEQ(args)
  await ctx.send(setEQs)


@bot.command(name="submitProposal", description="Researchers can submit new research proposals.")
  # Example: !submitProposal 234 "Exploring Genetic Variations"
async def _command4(ctx, *args):
  testModel = TestModel(ctx)
  enterProps = testModel.enterProp(args)
  await ctx.send(enterProps)


@bot.command(name="updateLabInfo", description="Update lab information, including lab name and maximum capacity.")
# Example: !updateLabInfo 789 "Advanced Genetics Lab" 50
async def _command5(ctx, *args):
  testModel = TestModel(ctx)
  updateLabs = testModel.updateLab(args)
  await ctx.send(updateLabs)


@bot.command(name="updateResearcherAffiliation", description="Update the affiliation of a researcher.")
async def _command6(ctx, *args):
    testModel = TestModel(ctx)
    updateRAs = testModel.updateRA(args)
    await ctx.send(updateRAs)


@bot.command(name="deleteExperimentResult", description="Delete experiment results with proper handling of related records.")
async def _command7(ctx, *args):
  testModel = TestModel(ctx)
  response = testModel.deleteER(args)
  await ctx.send(response)


@bot.command(name="deleteLabAccessRequest", description="Lab managers can delete lab access requests")
async def _command8(ctx, *args):
  testModel = TestModel(ctx)
  response = testModel.deleteLAR(args)
  await ctx.send(response)


@bot.command(name="getStoredResults", description=" Execute a stored procedure to retrieve experiment results with conditional statements.")
async def _command9(ctx, *args):
  testModel = TestModel(ctx)
  response = testModel.getSR(args)
  await ctx.send(response)


@bot.command(name="getProjectFunding", description="Retrieve project funding information using a function with loops.")
async def _command10(ctx, *args):
  testModel = TestModel(ctx)
  response = testModel.getPF(args)
  await ctx.send(response)


@bot.command(name="updateMaintenanceLog", description="Automatically update the last maintenance date in the Labs table when the maintenance log for equipment in that lab is updated.")
#Command: !updateMaintenanceLog <equipment_id> <new_maintenance_log>
async def _command11(ctx, *args):
  testModel = TestModel(ctx)
  response = testModel.updateML(args)
  await ctx.send(response)

@bot.command(name="insertSample", description="Automatically update the sample count for a project when a new sample is inserted for that project.")
async def _command12(ctx, *args):
  #Command: !insertSample <project_id> <sample_name> <description>
  testModel = TestModel(ctx)
  response = testModel.insertSample(args)
  await ctx.send(response)


@bot.command(name="getSample", description=" Users should be able to retrieve sample data including name and id. ")
#Command: !getSample <sample_id>
async def _command13(ctx, *args):
  testModel = TestModel(ctx)
  response = testModel.getSample(args)
  await ctx.send(response)
  
@bot.command(name="getCollaboratorCount", description="Execute a procedure to calculate the number of collaborators for a specific researcher.")
#Command: !getCollaboratorCount <researcher_id>
async def _command14(ctx, *args):
  testModel = TestModel(ctx)
  response = testModel.getCC(args)
  await ctx.send(response)


@bot.command(name="generateSampleID", description="Generate unique sample IDs based on a predefined format using a function.")
#Command: !generateSampleID <project_id>
async def _command15(ctx, *args):
  testModel = TestModel(ctx)
  response = testModel.genSI(args)
  await ctx.send(response)


bot.run(TOKEN)
