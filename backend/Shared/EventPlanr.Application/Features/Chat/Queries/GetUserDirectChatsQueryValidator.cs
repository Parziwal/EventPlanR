using EventPlanr.Application.Models.Pagination;
using FluentValidation;

namespace EventPlanr.Application.Features.Chat.Queries;

public class GetUserDirectChatsQueryValidator : AbstractValidator<GetUserDirectChatsQuery>
{
    public GetUserDirectChatsQueryValidator()
    {
        Include(new PageDtoValidator());
    }
}
