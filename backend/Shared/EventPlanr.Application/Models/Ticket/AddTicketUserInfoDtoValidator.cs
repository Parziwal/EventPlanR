using FluentValidation;

namespace EventPlanr.Application.Models.Ticket;

public class AddTicketUserInfoDtoValidator : AbstractValidator<AddTicketUserInfoDto>
{
    public AddTicketUserInfoDtoValidator()
    {
        RuleFor(x => x.TicketId)
            .NotEmpty();
        RuleFor(x => x.UserFirstName)
            .MaximumLength(64)
            .NotEmpty();
        RuleFor(x => x.UserLastName)
            .MaximumLength(64)
            .NotEmpty();
    }
}
