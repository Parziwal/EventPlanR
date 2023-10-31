using FluentValidation;

namespace EventPlanr.Application.Features.Chat.Queries;

public class GetChatMembersQueryValidator : AbstractValidator<GetChatMembersQuery>
{
    public GetChatMembersQueryValidator()
    {
        RuleFor(x => x.ChatId)
            .NotEmpty();
    }
}
