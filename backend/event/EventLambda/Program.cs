using Amazon;
using Amazon.DynamoDBv2;
using Amazon.DynamoDBv2.DataModel;
using EventLambda.Extensions;
using EventLambda.Requests;
using EventLambda.Settings;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddAWSLambdaHosting(LambdaEventSource.RestApi);
builder.Services.AddSingleton<IAmazonDynamoDB>(_ => new AmazonDynamoDBClient(RegionEndpoint.USEast1));
builder.Services.AddScoped<IDynamoDBContext, DynamoDBContext>();

builder.Services.AddMediatR(cfg => cfg.RegisterServicesFromAssembly(typeof(Program).Assembly));
builder.Services.Configure<DatabaseOption>(builder.Configuration.GetSection(nameof(DatabaseOption)));

var app = builder.Build();

app.MediateGet<GetEventListQuery>("event/list");

app.Run();
