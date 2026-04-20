Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA1B382F31
	for <netfs@lists.linux.dev>; Mon, 20 Apr 2026 07:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776670861; cv=none; b=DNCa3qp9D8n9lkGFN40QF4AsidEmlKfBC2MShUvw64DP76CLGLojgnYcz6+1nH5t77YBwrb/+SUR19mSSxhIIYz/AAn+aNXDg8fRYvQfB0fwX7ZGnb+t6Ph3aOQ4U9rk5GQ5+rezi0sTVgH942i7BtmMJ9JGYAoFXmUqtEwt9BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776670861; c=relaxed/simple;
	bh=l47MSXSP9+lis5rTGJHXZw3i0q2DO+l7eLUmBtd55jc=;
	h=From:To:cc:Subject:MIME-Version:Date:Message-ID:Content-Type; b=UQxWmd3AcuWfSnXtiQV+plFS1RhDrgU3nzqMDJ1/T/Pn74Mmsp20jk7QZf4nEVbl9avCxYMnN06tGZrI4OUwbMQ8IGsdEBGS+4vzXznh1qVf9P0iVbONihjIKXTrlCbpqE50yilF/9QBLMGZDkqFfnpPrpIC7ODVmSLEZPIRdOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P+c1RQuS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P+c1RQuS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776670859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=9jh/STLJe4e99VrBzEgIDCjpjJ2A2MME7myO4LRw6/w=;
	b=P+c1RQuSlb/zRdU0OlPz71HTB4iBvLJw6CsbikQT6YG6rZbzPD0z/nwFRsLK6ddKh6tEuX
	e0AJ8KmgSVBtkL1PVfZdlBA91hB4W9PESyc7Q8Xnc/m6MiNij+2k/WpwIZoUOjweh1aLb7
	KenatUrrvMmP7IPyWkJsbh3EZuULTEE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-173-f8sPLmHlOuaCNu7wQIiKxQ-1; Mon,
 20 Apr 2026 03:40:55 -0400
X-MC-Unique: f8sPLmHlOuaCNu7wQIiKxQ-1
X-Mimecast-MFC-AGG-ID: f8sPLmHlOuaCNu7wQIiKxQ_1776670854
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB6DB19560A7;
	Mon, 20 Apr 2026 07:40:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.17])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 250593000C15;
	Mon, 20 Apr 2026 07:40:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: git@vger.kernel.org
cc: dhowells@redhat.com, brauner@kernel.org, netfs@lists.linux.dev
Subject: git, network filesystems and is_path_owned_by_current_uid()
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Mon, 20 Apr 2026 08:40:51 +0100
Message-ID: <1005891.1776670851@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: wO6F56-JCvY8_78cGc41YLVzAP8fzHMaBcuYSMHrd0s_1776670854
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1005890.1776670851.1@warthog.procyon.org.uk>

Hi,

Can git's is_path_owned_by_current_uid() be made to check to see if the
filesystem is a network filesystem (9p, afs, ceph, cifs, nfs, maybe orange?)
before deciding that you're not allowed to do a command because your UID
doesn't match?

One way to do this would be to check the filesystem type returned by statfs:

	statfs(".", {f_type=AFS_FS_MAGIC, ...

Alternatively, we could add a statx() attribute flag in the kernel to indicate
that the uid/gid is from a separate set of IDs (or fabricated entirely) and
cannot by directly compared against system IDs.

Thanks,
David

