using FluentValidation;

namespace EventPlanr.Application.Features.Chat.Commands;
public class CreateChatMessageCommandValidator : AbstractValidator<CreateChatMessageCommand>
{
    public CreateChatMessageCommandValidator()
    {
        RuleFor(x => x.ChatId)
            .NotEmpty();
        RuleFor(x => x.UserId)
            .NotEmpty();
        RuleFor(x => x.Content)
           .NotEmpty();
    }
}
