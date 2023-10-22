using EventPlanr.Application.Contracts;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Security;
using EventPlanr.Domain.Constants;
using MediatR;

namespace EventPlanr.Application.Features.NewsPost.Commands;

[Authorize(OrganizationPolicy = OrganizationPolicies.NewsPostManage)]
public class DeleteNewsPostCommand : IRequest
{
    public Guid NewsPostId { get; set; }
}

public class DeleteNewsPostCommandHandler : IRequestHandler<DeleteNewsPostCommand>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IUserContext _user;

    public DeleteNewsPostCommandHandler(IApplicationDbContext dbContext, IUserContext user)
    {
        _dbContext = dbContext;
        _user = user;
    }

    public async Task Handle(DeleteNewsPostCommand request, CancellationToken cancellationToken)
    {
        var post = await _dbContext.NewsPosts
            .SingleEntityAsync(np => np.Id == request.NewsPostId && np.Event.OrganizationId == _user.OrganizationId);

        _dbContext.NewsPosts.Remove(post);
        await _dbContext.SaveChangesAsync();
    }
}
