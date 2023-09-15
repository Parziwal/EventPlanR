using EventPlanr.Application.Models.Pagination;
using FluentValidation;

namespace EventPlanr.Application.Features.Event.Queries;

public class GetUserUpcomingEventsValidator : AbstractValidator<GetUserUpcomingEventsQuery>
{
    public GetUserUpcomingEventsValidator()
    {
        Include(new PageDtoValidator());
    }
}
