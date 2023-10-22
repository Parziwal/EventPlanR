using FluentValidation;

namespace EventPlanr.Application.Features.NewsPost.Commands;

public class DeleteNewsPostCommandValidator : AbstractValidator<DeleteNewsPostCommand>
{
    public DeleteNewsPostCommandValidator()
    {
        RuleFor(x => x.NewsPostId)
            .NotEmpty();
    }
}
