using EventPlanr.Application.Contracts;
using EventPlanr.Domain.Entities;
using MediatR;

namespace EventPlanr.Application.Features.Organization.Commands;

public class CreateOrganizationCommand : IRequest<Guid>
{
    public string Name { get; set; } = null!;
    public string? Description { get; set; }
}

public class CreateOrganizationCommandHandler : IRequestHandler<CreateOrganizationCommand, Guid>
{
    private readonly IApplicationDbContext _dbContext;
    private readonly IUserContext _user;
    private readonly IUserService _userService;

    public CreateOrganizationCommandHandler(IApplicationDbContext context, IUserContext user, IUserService userService)
    {
        _dbContext = context;
        _user = user;
        _userService = userService;
    }

    public async Task<Guid> Handle(CreateOrganizationCommand request, CancellationToken cancellationToken)
    {
        var organization = new OrganizationEntity()
        {
            Name = request.Name,
            Description = request.Description,
            MemberUserIds = new List<Guid>() { _user.UserId },
        };

        _dbContext.Organizations.Add(organization);
        await _dbContext.SaveChangesAsync();

        await _userService.AddOrganizationToUserClaimsAsync(_user.UserId, organization.Id);

        return organization.Id;
    }
}