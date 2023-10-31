using FluentValidation;

namespace EventPlanr.Application.Features.Chat.Commands;

public class UpdateChatLastMessageDateCommandValidator : AbstractValidator<UpdateChatLastMessageDateCommand>
{
    public UpdateChatLastMessageDateCommandValidator()
    {
        RuleFor(x => x.ChatId)
            .NotEmpty();
        RuleFor(x => x.MessageDate)
            .NotEmpty();
    }
}
