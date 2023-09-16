using EventPlanr.Application.Models.Pagination;
using FluentValidation;

namespace EventPlanr.Application.Features.Event.Queries;

public class GetUserInvitationEventsQueryValidation : AbstractValidator<GetUserInvitationEventsQuery>
{
    public GetUserInvitationEventsQueryValidation()
    {
        Include(new PageDtoValidator());
    }
}
