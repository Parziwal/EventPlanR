using EventPlanr.Application.Models.Pagination;
using FluentValidation;

namespace EventPlanr.Application.Features.Chat.Queries;

public class GetUserEventChatsQueryValidator : AbstractValidator<GetUserEventChatsQuery>
{
    public GetUserEventChatsQueryValidator()
    {
        Include(new PageDtoValidator());
    }
}
