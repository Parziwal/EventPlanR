using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore.Migrations;
using NetTopologySuite.Geometries;

#nullable disable

namespace EventPlanr.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class Initial : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterDatabase()
                .Annotation("Npgsql:PostgresExtension:postgis", ",,");

            migrationBuilder.CreateTable(
                name: "chats",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    LastMessageDate = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_chats", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "orders",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    CustomerUserId = table.Column<Guid>(type: "uuid", nullable: false),
                    CustomerFirstName = table.Column<string>(type: "character varying(64)", maxLength: 64, nullable: false),
                    CustomerLastName = table.Column<string>(type: "character varying(64)", maxLength: 64, nullable: false),
                    BillingAddress_Country = table.Column<string>(type: "character varying(64)", maxLength: 64, nullable: false),
                    BillingAddress_ZipCode = table.Column<string>(type: "character varying(10)", maxLength: 10, nullable: false),
                    BillingAddress_City = table.Column<string>(type: "character varying(64)", maxLength: 64, nullable: false),
                    BillingAddress_AddressLine = table.Column<string>(type: "character varying(256)", maxLength: 256, nullable: false),
                    Total = table.Column<double>(type: "double precision", nullable: false),
                    Currency = table.Column<int>(type: "integer", nullable: false),
                    Created = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false),
                    CreatedBy = table.Column<string>(type: "text", nullable: true),
                    LastModified = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false),
                    LastModifiedBy = table.Column<string>(type: "text", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_orders", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "organizations",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    Name = table.Column<string>(type: "character varying(64)", maxLength: 64, nullable: false),
                    Description = table.Column<string>(type: "character varying(256)", maxLength: 256, nullable: true),
                    ProfileImageUrl = table.Column<string>(type: "text", nullable: true),
                    MemberUserIds = table.Column<List<Guid>>(type: "uuid[]", nullable: false),
                    Created = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false),
                    CreatedBy = table.Column<string>(type: "text", nullable: true),
                    LastModified = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false),
                    LastModifiedBy = table.Column<string>(type: "text", nullable: true),
                    IsDeleted = table.Column<bool>(type: "boolean", nullable: false),
                    DeletedAt = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_organizations", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "chat_members",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    MemberUserId = table.Column<Guid>(type: "uuid", nullable: false),
                    LastSeen = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false),
                    ChatId = table.Column<Guid>(type: "uuid", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_chat_members", x => x.Id);
                    table.ForeignKey(
                        name: "FK_chat_members_chats_ChatId",
                        column: x => x.ChatId,
                        principalTable: "chats",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "events",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    Name = table.Column<string>(type: "character varying(64)", maxLength: 64, nullable: false),
                    Description = table.Column<string>(type: "text", nullable: true),
                    CoverImageUrl = table.Column<string>(type: "text", nullable: true),
                    Category = table.Column<int>(type: "integer", nullable: false),
                    FromDate = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false),
                    ToDate = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false),
                    Venue = table.Column<string>(type: "character varying(64)", maxLength: 64, nullable: false),
                    Address_Country = table.Column<string>(type: "character varying(64)", maxLength: 64, nullable: false),
                    Address_ZipCode = table.Column<string>(type: "character varying(10)", maxLength: 10, nullable: false),
                    Address_City = table.Column<string>(type: "character varying(64)", maxLength: 64, nullable: false),
                    Address_AddressLine = table.Column<string>(type: "character varying(256)", maxLength: 256, nullable: false),
                    Coordinate = table.Column<Point>(type: "geography (point)", nullable: false),
                    Currency = table.Column<int>(type: "integer", nullable: false),
                    IsPrivate = table.Column<bool>(type: "boolean", nullable: false),
                    IsPublished = table.Column<bool>(type: "boolean", nullable: false),
                    OrganizationId = table.Column<Guid>(type: "uuid", nullable: false),
                    ChatId = table.Column<Guid>(type: "uuid", nullable: false),
                    Created = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false),
                    CreatedBy = table.Column<string>(type: "text", nullable: true),
                    LastModified = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false),
                    LastModifiedBy = table.Column<string>(type: "text", nullable: true),
                    IsDeleted = table.Column<bool>(type: "boolean", nullable: false),
                    DeletedAt = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_events", x => x.Id);
                    table.ForeignKey(
                        name: "FK_events_chats_ChatId",
                        column: x => x.ChatId,
                        principalTable: "chats",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_events_organizations_OrganizationId",
                        column: x => x.OrganizationId,
                        principalTable: "organizations",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "invitations",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    UserEmail = table.Column<string>(type: "character varying(128)", maxLength: 128, nullable: false),
                    UserId = table.Column<Guid>(type: "uuid", nullable: true),
                    Status = table.Column<int>(type: "integer", nullable: false),
                    IsCheckedIn = table.Column<bool>(type: "boolean", nullable: false),
                    EventId = table.Column<Guid>(type: "uuid", nullable: false),
                    Created = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false),
                    CreatedBy = table.Column<string>(type: "text", nullable: true),
                    LastModified = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false),
                    LastModifiedBy = table.Column<string>(type: "text", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_invitations", x => x.Id);
                    table.ForeignKey(
                        name: "FK_invitations_events_EventId",
                        column: x => x.EventId,
                        principalTable: "events",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "news_posts",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    Title = table.Column<string>(type: "character varying(64)", maxLength: 64, nullable: false),
                    Text = table.Column<string>(type: "text", nullable: false),
                    EventId = table.Column<Guid>(type: "uuid", nullable: false),
                    Created = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false),
                    CreatedBy = table.Column<string>(type: "text", nullable: true),
                    LastModified = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false),
                    LastModifiedBy = table.Column<string>(type: "text", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_news_posts", x => x.Id);
                    table.ForeignKey(
                        name: "FK_news_posts_events_EventId",
                        column: x => x.EventId,
                        principalTable: "events",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "tickets",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    Name = table.Column<string>(type: "character varying(64)", maxLength: 64, nullable: false),
                    Price = table.Column<double>(type: "double precision", nullable: false),
                    Count = table.Column<int>(type: "integer", nullable: false),
                    RemainingCount = table.Column<int>(type: "integer", nullable: false),
                    Description = table.Column<string>(type: "character varying(256)", maxLength: 256, nullable: true),
                    SaleStarts = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false),
                    SaleEnds = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false),
                    EventId = table.Column<Guid>(type: "uuid", nullable: false),
                    Created = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false),
                    CreatedBy = table.Column<string>(type: "text", nullable: true),
                    LastModified = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false),
                    LastModifiedBy = table.Column<string>(type: "text", nullable: true),
                    IsDeleted = table.Column<bool>(type: "boolean", nullable: false),
                    DeletedAt = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_tickets", x => x.Id);
                    table.ForeignKey(
                        name: "FK_tickets_events_EventId",
                        column: x => x.EventId,
                        principalTable: "events",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "sold_tickets",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    UserFirstName = table.Column<string>(type: "character varying(64)", maxLength: 64, nullable: false),
                    UserLastName = table.Column<string>(type: "character varying(64)", maxLength: 64, nullable: false),
                    Price = table.Column<double>(type: "double precision", nullable: false),
                    TicketId = table.Column<Guid>(type: "uuid", nullable: false),
                    OrderId = table.Column<Guid>(type: "uuid", nullable: false),
                    IsRefunded = table.Column<bool>(type: "boolean", nullable: false),
                    IsCheckedIn = table.Column<bool>(type: "boolean", nullable: false),
                    CheckInDate = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_sold_tickets", x => x.Id);
                    table.ForeignKey(
                        name: "FK_sold_tickets_orders_OrderId",
                        column: x => x.OrderId,
                        principalTable: "orders",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_sold_tickets_tickets_TicketId",
                        column: x => x.TicketId,
                        principalTable: "tickets",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateIndex(
                name: "IX_chat_members_ChatId",
                table: "chat_members",
                column: "ChatId");

            migrationBuilder.CreateIndex(
                name: "IX_events_ChatId",
                table: "events",
                column: "ChatId",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_events_OrganizationId",
                table: "events",
                column: "OrganizationId");

            migrationBuilder.CreateIndex(
                name: "IX_invitations_EventId",
                table: "invitations",
                column: "EventId");

            migrationBuilder.CreateIndex(
                name: "IX_news_posts_EventId",
                table: "news_posts",
                column: "EventId");

            migrationBuilder.CreateIndex(
                name: "IX_sold_tickets_OrderId",
                table: "sold_tickets",
                column: "OrderId");

            migrationBuilder.CreateIndex(
                name: "IX_sold_tickets_TicketId",
                table: "sold_tickets",
                column: "TicketId");

            migrationBuilder.CreateIndex(
                name: "IX_tickets_EventId",
                table: "tickets",
                column: "EventId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "chat_members");

            migrationBuilder.DropTable(
                name: "invitations");

            migrationBuilder.DropTable(
                name: "news_posts");

            migrationBuilder.DropTable(
                name: "sold_tickets");

            migrationBuilder.DropTable(
                name: "orders");

            migrationBuilder.DropTable(
                name: "tickets");

            migrationBuilder.DropTable(
                name: "events");

            migrationBuilder.DropTable(
                name: "chats");

            migrationBuilder.DropTable(
                name: "organizations");
        }
    }
}
