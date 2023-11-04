using FluentValidation;

namespace EventPlanr.Application.Features.Chat.Commands;

public class SetChatMessagesReadCommandValidator : AbstractValidator<SetChatMessagesReadCommand>
{
    public SetChatMessagesReadCommandValidator()
    {
        RuleFor(x => x.ChatId)
            .NotEmpty();
    }
}
