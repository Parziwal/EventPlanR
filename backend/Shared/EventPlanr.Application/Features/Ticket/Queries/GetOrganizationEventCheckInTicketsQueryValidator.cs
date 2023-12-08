using EventPlanr.Application.Models.Pagination;
using FluentValidation;

namespace EventPlanr.Application.Features.Ticket.Queries;

public class GetOrganizationEventCheckInTicketsQueryValidator : AbstractValidator<GetOrganizationEventCheckInTicketsQuery>
{
    public GetOrganizationEventCheckInTicketsQueryValidator()
    {
        Include(new PageDtoValidator());
        RuleFor(x => x.EventId)
            .NotEmpty();
    }
}
