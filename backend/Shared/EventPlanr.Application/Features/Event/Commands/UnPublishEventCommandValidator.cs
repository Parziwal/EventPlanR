using FluentValidation;

namespace EventPlanr.Application.Features.Event.Commands;

public class UnPublishEventCommandValidator : AbstractValidator<UnPublishEventCommand>
{
    public UnPublishEventCommandValidator()
    {
        RuleFor(x => x.EventId)
            .NotEmpty();
    }
}
