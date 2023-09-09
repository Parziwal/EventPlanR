using EventPlanr.Application;
using EventPlanr.Application.Features.Event.Queries;
using EventPlanr.Configuration;
using EventPlanr.Domain.Enums;
using EventPlanr.Infrastructure;
using MediatR;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddAWSLambdaHosting(LambdaEventSource.HttpApi);

builder.Configuration.AddConfigurationSettings();
builder.Services.AddApplicationServices();
builder.Services.AddInfrastructureServices(builder.Configuration);

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.MapGet("/event/general", (
    string? searchTerm,
    EventCategory? category,
    DateTimeOffset? fromDate,
    DateTimeOffset? toDate,
    double? latitude,
    double? longitude,
    IMediator mediator) => {
    return mediator.Send(new GetFilteredEventsQuery()
    {
        SearchTerm = searchTerm,
        Category = category,
        FromDate = fromDate,
        ToDate = toDate,
        Latitude = latitude,
        Longitude = longitude,
    });
});

app.MapGet("/event/general/{eventId}", (Guid eventId, IMediator mediator) => {
    return mediator.Send(new GetEventDetailsQuery()
    {
        EventId = eventId,
    });
});


app.Run();
