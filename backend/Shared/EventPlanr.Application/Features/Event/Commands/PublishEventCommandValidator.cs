using FluentValidation;

namespace EventPlanr.Application.Features.Event.Commands;

public class PublishEventCommandValidator : AbstractValidator<PublishEventCommand>
{
    public PublishEventCommandValidator()
    {
        RuleFor(x => x.EventId)
            .NotEmpty();
    }
}
