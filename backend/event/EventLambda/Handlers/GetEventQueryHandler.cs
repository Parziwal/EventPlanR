using Amazon.DynamoDBv2.DataModel;
using EventLambda.Models;
using EventLambda.Requests;
using EventLambda.Settings;
using MediatR;
using Microsoft.Extensions.Options;

namespace EventLambda.Handlers;

public class GetEventListQueryHandler : IRequestHandler<GetEventListQuery, List<Event>>
{
    private readonly IDynamoDBContext _dbContext;
    private readonly IOptions<DatabaseOption> _databaseOption;

    public GetEventListQueryHandler(IDynamoDBContext dbContext, IOptions<DatabaseOption> databaseOption)
    {
        _dbContext = dbContext;
        _databaseOption = databaseOption;
    }

    public async Task<List<Event>> Handle(GetEventListQuery request,
        CancellationToken cancellationToken)
    {
        return await _dbContext.ScanAsync<Event>(default).GetRemainingAsync();
    }
}
