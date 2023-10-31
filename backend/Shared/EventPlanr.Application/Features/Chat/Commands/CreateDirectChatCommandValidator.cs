using FluentValidation;

namespace EventPlanr.Application.Features.Chat.Commands;
public class CreateDirectChatCommandValidator : AbstractValidator<CreateDirectChatCommand>
{
    public CreateDirectChatCommandValidator()
    {
        RuleFor(x => x.UserEmail)
            .NotEmpty();
    }
}
