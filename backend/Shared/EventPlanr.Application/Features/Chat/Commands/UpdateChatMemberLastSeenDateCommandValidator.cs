using FluentValidation;

namespace EventPlanr.Application.Features.Chat.Commands;

public class UpdateChatMemberLastSeenDateCommandValidator : AbstractValidator<UpdateChatMemberLastSeenDateCommand>
{
    public UpdateChatMemberLastSeenDateCommandValidator()
    {
        RuleFor(x => x.ChatId)
            .NotEmpty();
        RuleFor(x => x.UserId)
            .NotEmpty();
        RuleFor(x => x.LastSeenDate)
            .NotEmpty();
    }
}
