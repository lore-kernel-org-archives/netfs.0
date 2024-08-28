Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE10158DC2
	for <netfs@lists.linux.dev>; Wed, 28 Aug 2024 10:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724841472; cv=none; b=KsGBlPFkgJmoBGNeb4nsSq1lK+QX92w3k12exxhlu8ouNTI81UYBG7TCxdpWrpUwPnUBKNlS6Qkv8BU2ZcyQ6vSSRsnwcYTWi/WjkY+fPL8tj6+NG8QK+DvOsVgxSj6MjGPMSW2dhuUODsPxCrvF4rcmeBY+J0mZtKbb2/3h1lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724841472; c=relaxed/simple;
	bh=awO9DQBZwmRwy4r7lJ+MHeDWGPO1ch0i7FbvQQz5STw=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=KjowXFF27lyfsWYrcKr+EBgcNjOcJ+Kirl6FvdQyPRSdnTx1bGyY1Rn81qDuA/wjBsFi/MtHBJe96KvyGhuGgIZNzGwP81wsyJpJaGciu87BckFm1jQCaOZzwhvTAFHrYxKWXBrlrtHLrCBvVQlIpWb7nR4cOh0iu7dEl9krBEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DvNUmuNM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DvNUmuNM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724841469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jzUkFIussh+cyc5LHCiRLDkre+V+EO0118aAT2+MjKQ=;
	b=DvNUmuNMhCJ0PSurKDEUtRbSkukZ7j8J99w70yj15r1HTOoTGwlPdbBSYlRkJpR9ds1oV8
	G38S4ZFN/viVpKoqE2OBvKh2f7c8Sr+IsK7gkUv/sRh27E2yZ2l7q302C/JB7KaiPoQ19e
	d6R14kye7ApqGugPvAGUZLJLmKfHm4s=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-xiNa3xA0NW2wayu8oJcNdg-1; Wed,
 28 Aug 2024 06:37:46 -0400
X-MC-Unique: xiNa3xA0NW2wayu8oJcNdg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E17A1955D4C;
	Wed, 28 Aug 2024 10:37:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.30])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 58CDF1955D56;
	Wed, 28 Aug 2024 10:37:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240826113404.3214786-1-libaokun@huaweicloud.com>
References: <20240826113404.3214786-1-libaokun@huaweicloud.com>
To: libaokun@huaweicloud.com
Cc: dhowells@redhat.com, netfs@lists.linux.dev, jlayton@kernel.org,
    hsiangkao@linux.alibaba.com, jefflexu@linux.alibaba.com,
    linux-erofs@lists.ozlabs.org, brauner@kernel.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    yangerkun@huawei.com, houtao1@huawei.com, yukuai3@huawei.com,
    wozizhi@huawei.com, Baokun Li <libaokun1@huawei.com>,
    stable@kernel.org
Subject: Re: [PATCH] netfs: Delete subtree of 'fs/netfs' when netfs module exits
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <952422.1724841455.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Aug 2024 11:37:35 +0100
Message-ID: <952423.1724841455@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

libaokun@huaweicloud.com wrote:

> In netfs_init() or fscache_proc_init(), we create dentry under 'fs/netfs=
',
> but in netfs_exit(), we only delete the proc entry of 'fs/netfs' without
> deleting its subtree. This triggers the following WARNING:
> =

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> remove_proc_entry: removing non-empty directory 'fs/netfs', leaking at l=
east 'requests'
> WARNING: CPU: 4 PID: 566 at fs/proc/generic.c:717 remove_proc_entry+0x16=
0/0x1c0
> Modules linked in: netfs(-)
> CPU: 4 UID: 0 PID: 566 Comm: rmmod Not tainted 6.11.0-rc3 #860
> RIP: 0010:remove_proc_entry+0x160/0x1c0
> Call Trace:
>  <TASK>
>  netfs_exit+0x12/0x620 [netfs]
>  __do_sys_delete_module.isra.0+0x14c/0x2e0
>  do_syscall_64+0x4b/0x110
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =

> Therefore use remove_proc_subtree instead() of remove_proc_entry() to
> fix the above problem.
> =

> Fixes: 7eb5b3e3a0a5 ("netfs, fscache: Move /proc/fs/fscache to /proc/fs/=
netfs and put in a symlink")
> Cc: stable@kernel.org
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Should remove_proc_entry() just remove the entire subtree anyway?

But you can add:

	Acked-by: David Howells <dhowells@redhat.com>

David

