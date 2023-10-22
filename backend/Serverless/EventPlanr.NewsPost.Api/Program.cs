using EventPlanr.LambdaBase;

var builder = WebApplication.CreateBuilder(args);

builder.AddServerlessLambdaServices();

var app = builder.Build();

app.UseServerlessLambda();

app.Run();
