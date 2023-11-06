using EventPlanr.Application.Contracts;
using EventPlanr.Application.Security;
using MediatR;

namespace EventPlanr.Application.Features.User.Commands;

[Authorize]
public class UploadUserProfileImageCommand : IRequest<string>
{
    public byte[] Image { get; set; } = null!;
}

public class UploadUserProfileImageCommandHandler : IRequestHandler<UploadUserProfileImageCommand, string>
{
    public IImageService _imageService;
    public IUserContext _user;
    public IUserService _userService;

    public UploadUserProfileImageCommandHandler(
        IImageService imageService,
        IUserContext user,
        IUserService userService)
    {
        _imageService = imageService;
        _user = user;
        _userService = userService;
    }

    public async Task<string> Handle(UploadUserProfileImageCommand request, CancellationToken cancellationToken)
    {
        var user = await _userService.GetUserById(_user.UserId);

        var imageUrl = await _imageService.UploadImage(request.Image);

        if (user!.Picture != null)
        {
            await _imageService.DeleteImage(user.Picture.Split('/').Last());
        }

        await _userService.SetUserProfilePicture(_user.UserId.ToString(), imageUrl);

        return imageUrl;
    }
}