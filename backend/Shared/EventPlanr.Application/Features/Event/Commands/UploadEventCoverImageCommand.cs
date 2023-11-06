using EventPlanr.Application.Contracts;
using EventPlanr.Application.Extensions;
using EventPlanr.Application.Security;
using EventPlanr.Domain.Constants;
using MediatR;

namespace EventPlanr.Application.Features.Event.Commands;

[Authorize(OrganizationPolicy = OrganizationPolicies.OrganizationEventManage)]
public class UploadEventCoverImageCommand : IRequest<string>
{
    public Guid EventId { get; set; }
    public byte[] Image { get; set; } = null!;
}

public class UploadEventCoverImageCommandHandler : IRequestHandler<UploadEventCoverImageCommand, string>
{
    public IApplicationDbContext _dbContext;
    public IImageService _imageService;
    public IUserContext _user;

    public UploadEventCoverImageCommandHandler(
        IApplicationDbContext dbContext,
        IImageService imageService,
        IUserContext user)
    {
        _dbContext = dbContext;
        _imageService = imageService;
        _user = user;
    }

    public async Task<string> Handle(UploadEventCoverImageCommand request, CancellationToken cancellationToken)
    {
        var eventEntity = await _dbContext.Events
            .SingleEntityAsync(e => e.Id == request.EventId && e.OrganizationId == _user.OrganizationId);

        var imageUrl = await _imageService.UploadImage(request.Image);

        if (eventEntity.CoverImageUrl != null)
        {
            await _imageService.DeleteImage(eventEntity.CoverImageUrl.Split('/').Last());
        }
        eventEntity.CoverImageUrl = imageUrl;

        await _dbContext.SaveChangesAsync();
        return imageUrl;
    }
}