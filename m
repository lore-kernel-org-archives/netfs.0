Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49956283FE5
	for <netfs@lists.linux.dev>; Fri, 27 Jun 2025 10:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751018432; cv=none; b=RZMZ5HvUANc8cnCdNQyLB6kClHIch5wkn6Mz1t5Nsyea0LRCYH+VHdpitNrnE0d6TfoP+Vo8R0ijFF44gfBPofRTCLy3LkcrinG34gA9OFZB6vW6hLhLtaFcZmgQnU/37TI7aH1QgPM8T9mJR3PTo2tfJAIG7VO5r7zSgQYWD+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751018432; c=relaxed/simple;
	bh=ycgp8smJ6qdGyb5KS618NZdgUuBZ+K4vqVR3TSDiRQc=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=Fewvser9vh6XQGIsym336JQS7P97MewUuroS5ILqXIoFCIBOissQhhUbb2Uh56q2A9qeYXpuTr5vOJt4bo6RlQ+I/6X7WfUlB8K+11V3zgjJStpSV4NUZLXIlqYqWsx2P/uWe8KcTEa/kNH/jJhQuPB6N7a2Ft0tvLbPF9XrBS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PSQZ9OaS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PSQZ9OaS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751018429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QJARBrsQDqMKecVsW7RxG7g2Bw7hM8qYS7pvleV7J9M=;
	b=PSQZ9OaS64kl2wkjhvylthAD1ZzoymgucRDM+iCU96QkBNKBsa23jwDpNuhy9JjpPKOkGi
	gUZVw2JJL/G1T3ZfJcQROrlQ+H6H9eqstsyXy+MdREIdcQbHAgnFTR4HnAnhFkrMi5cUhu
	P4C+1feu+2Sx3rOc0FwmZT/2Dc2giJQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-367-RMGKsNt1P7uKfPssuN3BUA-1; Fri,
 27 Jun 2025 06:00:19 -0400
X-MC-Unique: RMGKsNt1P7uKfPssuN3BUA-1
X-Mimecast-MFC-AGG-ID: RMGKsNt1P7uKfPssuN3BUA_1751018416
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 43E5E1801222;
	Fri, 27 Jun 2025 10:00:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.81])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 97DA21944CE7;
	Fri, 27 Jun 2025 10:00:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <w5ap2zcsatkx4dmakrkjmaexwh3mnmgc5vhavb2miaj6grrzat@7kzr5vlsrmh5>
References: <w5ap2zcsatkx4dmakrkjmaexwh3mnmgc5vhavb2miaj6grrzat@7kzr5vlsrmh5> <ZxFQw4OI9rrc7UYc@Antony2201.local> <D4LHHUNLG79Y.12PI0X6BEHRHW@mbosch.me> <c3eff232-7db4-4e89-af2c-f992f00cd043@leemhuis.info> <D4LNG4ZHZM5X.1STBTSTM9LN6E@mbosch.me> <CA+icZUVkVcKw+wN1p10zLHpO5gqkpzDU6nH46Nna4qaws_Q5iA@mail.gmail.com> <3327438.1729678025@warthog.procyon.org.uk> <ZxlQv5OXjJUbkLah@moon.secunet.de>
To: Ryan Lahfa <ryan@lahfa.xyz>
Cc: dhowells@redhat.com, Antony Antony <antony.antony@secunet.com>,
    Antony Antony <antony@phenome.org>,
    Christian Brauner <brauner@kernel.org>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Latchesar Ionkov <lucho@ionkov.net>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Christian Schoenebeck <linux_oss@crudebyte.com>,
    Sedat Dilek <sedat.dilek@gmail.com>,
    Maximilian Bosch <maximilian@mbosch.me>, regressions@lists.linux.dev,
    v9fs@lists.linux.dev, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] 9pfs issues on 6.12-rc1
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1641292.1751018406.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Jun 2025 11:00:06 +0100
Message-ID: <1641293.1751018406@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Ryan Lahfa <ryan@lahfa.xyz> wrote:

> Here is how to reproduce it:
> =

> $ git clone https://gerrit.lix.systems/lix
> $ cd lix
> $ git fetch https://gerrit.lix.systems/lix refs/changes/29/3329/8 && git=
 checkout FETCH_HEAD
> $ nix-build -A hydraJobs.tests.local-releng

How do I build and run this on Fedora is the problem :-/

> [1]: https://gist.dgnum.eu/raito/3d1fa61ebaf642218342ffe644fb6efd

Looking at this, it looks very much like a page may have been double-freed=
.

Just to check, what are you using 9p for?  Containers?  And which transpor=
t is
being used, the virtio one?

David

