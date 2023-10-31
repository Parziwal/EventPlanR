using FluentValidation;

namespace EventPlanr.Application.Features.Chat.Queries;

public class GetChatMessagesQueryValidator : AbstractValidator<GetChatMessagesQuery>
{
    public GetChatMessagesQueryValidator()
    {
        RuleFor(x => x.ChatId)
            .NotEmpty();
    }
}
