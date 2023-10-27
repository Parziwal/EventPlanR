using EventPlanr.Application.Contracts;
using EventPlanr.Application.Exceptions;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Security;
using EventPlanr.Domain.Constants;
using EventPlanr.Domain.Entities;
using MediatR;
using System.Text.Json.Serialization;

namespace EventPlanr.Application.Features.NewsPost.Commands;

[Authorize(OrganizationPolicy = OrganizationPolicies.NewsPostManage)]
public class CreateNewsPostCommand : IRequest<Guid>
{
    [JsonIgnore]
    public Guid EventId { get; set; }
    public string Title { get; set; } = null!;
    public string Text { get; set; } = null!;
}

public class CreateNewsPostCommandHandler : IRequestHandler<CreateNewsPostCommand, Guid>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IUserContext _user;

    public CreateNewsPostCommandHandler(IApplicationDbContext dbContext, IUserContext user)
    {
        _dbContext = dbContext;
        _user = user;
    }

    public async Task<Guid> Handle(CreateNewsPostCommand request, CancellationToken cancellationToken)
    {
        var eventEntity = await _dbContext.Events
            .SingleEntityAsync(e => e.Id == request.EventId && e.OrganizationId == _user.OrganizationId);

        var post = new NewsPostEntity()
        {
            Title = request.Title,
            Text = request.Text,
            EventId = request.EventId,
        };

        _dbContext.NewsPosts.Add(post);

        await _dbContext.SaveChangesAsync();

        return post.Id;
    }
}
