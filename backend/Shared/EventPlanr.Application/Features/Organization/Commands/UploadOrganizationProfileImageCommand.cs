using EventPlanr.Application.Contracts;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Security;
using EventPlanr.Domain.Constants;
using MediatR;

namespace EventPlanr.Application.Features.Organization.Commands;


[Authorize(OrganizationPolicy = OrganizationPolicies.OrganizationManage)]
public class UploadOrganizationProfileImageCommand : IRequest<string>
{
    public byte[] Image { get; set; } = null!;
}

public class UploadOrganizationProfileImageCommandHandler : IRequestHandler<UploadOrganizationProfileImageCommand, string>
{
    public IApplicationDbContext _dbContext;
    public IImageService _imageService;
    public IUserContext _user;

    public UploadOrganizationProfileImageCommandHandler(
        IApplicationDbContext dbContext,
        IImageService imageService,
        IUserContext user)
    {
        _dbContext = dbContext;
        _imageService = imageService;
        _user = user;
    }

    public async Task<string> Handle(UploadOrganizationProfileImageCommand request, CancellationToken cancellationToken)
    {
        var organization = await _dbContext.Organizations
            .SingleEntityAsync(e => e.Id == _user.OrganizationId);

        var imageUrl = await _imageService.UploadImage(request.Image);

        if (organization.ProfileImageUrl != null)
        {
            await _imageService.DeleteImage(organization.ProfileImageUrl.Split('/').Last());
        }
        organization.ProfileImageUrl = imageUrl;

        await _dbContext.SaveChangesAsync();
        return imageUrl;
    }
}