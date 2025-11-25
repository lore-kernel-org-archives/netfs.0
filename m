Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0A226C39E
	for <netfs@lists.linux.dev>; Tue, 25 Nov 2025 11:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764069563; cv=none; b=BSYgzBctrQ7oOKPeeV5cXzSTQm7JnZhfb8NIFK8wIc9WlMLqd8RaKcNJDOS9omQBBxtJ0eejnp3suxhc1dvCv7mgUN663IRc/6un/A8l+xD4GS8CGTrRq2QYeolAR6CUkCZbMoDVW4BF77h9YqdxiClT/QcBAoUvEoclV0svrAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764069563; c=relaxed/simple;
	bh=/NC1xwO49uYYM7O+fI9Z6odSxnwmaittw4kmCbo4nUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bpW4Z+BSdOx6iXGr3EW0KXxP3C6y2nYmURA4mGEP0ElcLIgkAVTi6oRldZf8jc0Zqergduot8LH8Mys8xeNqRH9j7qwSgNUS06BejpMntQNs643iNplFc3HNKKuACFIZ70sHd3p7F+63BYUANlP0SLFP/UBeYSmuGYe8aIJfpGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=z2+gmSYB; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="z2+gmSYB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=/NC1xwO49uYYM7O+fI9Z6odSxnwmaittw4kmCbo4nUc=; b=z2+gmSYBS1G89FimoQ/Km9qaTt
	3y3lT7XcBGPZ8UcwT9RRUaCNTkEmtno+TfoQn5JnbERpuq2cXJi3DOWlynbib/7Z9JJA6ERpNB+hq
	806obx4Oyusb1kwj7ve9dyRs2ktYRZpixzKg0EuF0xrOhQ/SE/8E5CnubMTlQ1ZDPbvtLF9sVZVkK
	VCk+Hx5iFqJ2p+dmDaXBQAVhNShoOCD+chaOVk0lwoVHMB1IYff2QCZS5lz59HngzKZsMhARzgwgQ
	k0Q6UyE/Wcd/Li73ilbQFtgd3IeX151KVO3/k0L+WmlQfs3btKu+04uawsfCGSrMH2d1xj9MV3KhU
	40jBrbu7WIYPMmR5+daX8/kL0k9X81EI4CQ+lbDJfBwPkhgtLbFk9SjciUYxc8gF92QCI4b7eWzb4
	FF2Tfr5xTAyDVqDBKZZJqNEWWzZfv01rEyKIQFGwaEO8CMM9wjP49izGj93TEsPwG48Ig8k1Tth8+
	RNbh5LL5n6kBKqzh0AnYel9s;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1vNr4o-00FZT7-0l;
	Tue, 25 Nov 2025 11:19:18 +0000
Message-ID: <21b1fef8-010c-4eb2-a995-10bf822c7cc3@samba.org>
Date: Tue, 25 Nov 2025 12:19:17 +0100
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/11] cifs: Clean up some places where an extra kvec[]
 was required for rfc1002
To: David Howells <dhowells@redhat.com>
Cc: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>,
 Shyam Prasad N <sprasad@microsoft.com>, linux-cifs@vger.kernel.org,
 netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tom Talpey <tom@talpey.com>
References: <b14a083e-d754-48a9-b480-1344a07479aa@samba.org>
 <ad8ef7da-db2a-4033-8701-cf2fc61b8a1d@samba.org>
 <7b897d50-f637-4f96-ba64-26920e314739@samba.org>
 <20251124124251.3565566-1-dhowells@redhat.com>
 <20251124124251.3565566-8-dhowells@redhat.com>
 <3635951.1763995018@warthog.procyon.org.uk>
 <3639864.1763995480@warthog.procyon.org.uk>
 <3677674.1764069095@warthog.procyon.org.uk>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <3677674.1764069095@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi David,

> Do you want me to repost my patches so you can associate URLs with them?

I don't need that, I'm just rebasing on your branch now.

I don't know what Steve needs in order to put it into ksmbd-for-next
and what review tags from Tom he should add.

Steve feel free to add 'Acked-by: Stefan Metzmacher <metze@samba.org>'

Thanks!
metze
