using EventPlanr.Application.Models.Pagination;
using FluentValidation;

namespace EventPlanr.Application.Features.Event.Queries;

public class GetUserPastEventsQueryValidator : AbstractValidator<GetUserPastEventsQuery>
{
    public GetUserPastEventsQueryValidator()
    {
        Include(new PageDtoValidator());
    }
}
