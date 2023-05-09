namespace Ticket.Application.Dto;

public class BuyTicketDto
{
    public string TicketName { get; set; } = default!;
    public int Quantity { get; set; }
}
