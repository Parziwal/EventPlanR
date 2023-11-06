using FluentValidation;

namespace EventPlanr.Application.Features.Event.Commands;

public class UploadEventCoverImageCommandValidator : AbstractValidator<UploadEventCoverImageCommand>
{
    public UploadEventCoverImageCommandValidator()
    {
        RuleFor(x => x.EventId)
            .NotEmpty();
        RuleFor(x => x.Image)
            .NotEmpty();
    }
}
