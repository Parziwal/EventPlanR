using FluentValidation;

namespace EventPlanr.Application.Features.Ticket.Queries;

public class GetCheckInTicketDetailsQueryValidator : AbstractValidator<GetCheckInTicketDetailsQuery>
{
    public GetCheckInTicketDetailsQueryValidator()
    {
        RuleFor(x => x.SoldTicketId)
            .NotEmpty();
    }
}
