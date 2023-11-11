using EventPlanr.Application.Models.Pagination;
using FluentValidation;

namespace EventPlanr.Application.Features.Ticket.Queries;

public class GetOrganizationEventCheckInTicketsQueryValidator : AbstractValidator<GetOrganizationEvenCheckInTicketsQuery>
{
    public GetOrganizationEventCheckInTicketsQueryValidator()
    {
        Include(new PageDtoValidator());
        RuleFor(x => x.EventId)
            .NotEmpty();
    }
}
