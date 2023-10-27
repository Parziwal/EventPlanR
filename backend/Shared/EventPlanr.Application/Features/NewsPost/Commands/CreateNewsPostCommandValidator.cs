using FluentValidation;

namespace EventPlanr.Application.Features.NewsPost.Commands;

public class CreateNewsPostCommandValidator : AbstractValidator<CreateNewsPostCommand>
{
    public CreateNewsPostCommandValidator()
    {
        RuleFor(x => x.EventId)
            .NotEmpty();
        RuleFor(x => x.Title)
            .NotEmpty()
            .MaximumLength(64);
        RuleFor(x => x.Text)
            .NotEmpty();

    }
}
