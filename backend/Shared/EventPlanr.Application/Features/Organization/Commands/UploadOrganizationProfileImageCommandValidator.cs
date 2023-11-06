using FluentValidation;

namespace EventPlanr.Application.Features.Organization.Commands;

public class UploadOrganizationProfileImageCommandValidator : AbstractValidator<UploadOrganizationProfileImageCommand>
{
    public UploadOrganizationProfileImageCommandValidator()
    {
        RuleFor(x => x.Image)
            .NotEmpty();
    }
}
