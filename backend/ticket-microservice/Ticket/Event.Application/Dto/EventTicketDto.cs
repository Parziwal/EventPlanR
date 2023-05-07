namespace Ticket.Application.Dto;

public class EventTicketDto
{
    public string Name { get; set; } = default!;
    public double Price { get; set; }
    public string Description { get; set; } = default!;
}
