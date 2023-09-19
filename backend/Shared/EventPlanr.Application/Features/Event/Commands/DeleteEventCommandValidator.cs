using FluentValidation;

namespace EventPlanr.Application.Features.Event.Commands;

public class DeleteEventCommandValidator : AbstractValidator<DeleteEventCommand>
{
    public DeleteEventCommandValidator()
    {
        RuleFor(x => x.EventId)
            .NotEmpty();
    }
}
